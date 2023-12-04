#!/bin/bash
# script to install ldap on the headnode of the cluster
#
# Copyright (C) 2018 by Dr. Dominik Straßel
#-----------------------------------------------------------------------------------------------------------------------------------

CLUSTER_DIR="/opt/Carme"
CONFIG_FILE="CarmeConfig"

SETCOLOR='\033[1;33m'
NOCOLOR='\033[0m'
printf "\n"
#-----------------------------------------------------------------------------------------------------------------------------------

if [ ! $(whoami) = "root" ]; then
    printf "${SETCOLOR}you need root privileges to run this script${NOCOLOR}\n\n"
    exit 137
fi

if [ -f $CLUSTER_DIR/$CONFIG_FILE ]; then
    source $CLUSTER_DIR/$CONFIG_FILE
else
    printf "${SETCOLOR}no config-file found in $CLUSTER_DIR${NOCOLOR}\n"
    exit 137
fi

THIS_NODE_IPS=( $(hostname -I) )
if [[ ! " ${THIS_NODE_IPS[@]} " =~ " ${CARME_HEADNODE_IP} " ]]; then
    printf "${SETCOLOR}this is not the Headnode${NOCOLOR}\n"
    exit 137
fi

if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then

WORKINGDIR=/tmp/ldapconfig
LDAPCONFIGDIR=/etc/ldap
SCHEMADIR=$LDAPCONFIGDIR/schema
SAMBAINSTALLED='Y'
SLAPDINSTALLED='Y'
ROOTDN="dc=$CARME_LDAP_DC1,dc=$CARME_LDAP_DC2"

if [ "$(id -u)" != "0" ]; then
	printf "${SETCOLOR}This script must be run as root${NOCOLOR}\n"
	exit 192
fi

printf "${SETCOLOR}purging former slapd installations${NOCOLOR}\n"
apt purge -y slapd ldap-utils
apt autoremove -y --purge
rm -rv /etc/ldap
rm -rv /var/lib/ldap


if [ ! -x /usr/sbin/slappasswd ]; then
	printf "${SETCOLOR}Openldap seems not to be installed.${NOCOLOR}\n"
	printf "${SETCOLOR}Shall I do that for you? [Y|n]${NOCOLOR}\n"
	read SLAPDINSTALLED
	if [ $SLAPDINSTALLED=='Y' ]; then
		apt install -y slapd ldap-utils
	fi
fi

dpkg-reconfigure slapd

cat << EOF > /etc/ldap/ldap.conf
#
#Defaults
#

# See ldap.conf(5) for details
# This file should be world readable but not world writable.

BASE    dc=$CARME_LDAP_DC1,dc=$CARME_LDAP_DC2
URI     $CARME_LDAP_URI

LDAP_VERSION     3
EOF



if [ ! -d $WORKINGDIR ]; then
	mkdir -p $WORKINGDIR
else
	printf "${SETCOLOR}It seems that a prevoius config is present. Titiying up.${NOCOLOR}\n"
	rm -rf $WORKINGDIR
fi

if [ ! -d $WORKINGDIR/schema/ ]; then
	mkdir -p $WORKINGDIR/schema/
fi

cat << EOF > $WORKINGDIR/slapd_temporary.conf
include /etc/ldap/schema/core.schema
include /etc/ldap/schema/collective.schema
include /etc/ldap/schema/corba.schema
include /etc/ldap/schema/cosine.schema
include /etc/ldap/schema/duaconf.schema
include /etc/ldap/schema/dyngroup.schema
include /etc/ldap/schema/inetorgperson.schema
include /etc/ldap/schema/java.schema
include /etc/ldap/schema/misc.schema
include /etc/ldap/schema/nis.schema
include /etc/ldap/schema/openldap.schema
include /etc/ldap/schema/ppolicy.schema
include /etc/ldap/schema/ldapns.schema
include /etc/ldap/schema/pmi.schema
EOF

slapcat -f $WORKINGDIR/slapd_temporary.conf -F $WORKINGDIR -n0 2>&1 > /dev/null

printf "${SETCOLOR}Updating gnerated Schemas${NOCOLOR}\n"

for FILE in $WORKINGDIR/cn\=config/cn\=schema/*.ldif; do
	printf "${SETCOLOR}Updating ldif schema file for '${FILE#*\}}'${NOCOLOR}\n"
	# remove file before filling it with contents
	rm -f $SCHEMADIR/${FILE#*\}}

	while IFS='#' read LINE; do
		case ${LINE%%:*} in
		"dn")
		LINE="dn: cn="${LINE#*\}}", cn=schema, cn=config"
		;;

		"cn")
		LINE="cn: "${LINE#*\}}
		;;

		"structuralObjectClass")
		unset LINE
		;;

		"entryUUID")
		unset LINE
		;;

		"creatorsName")
		unset LINE
		;;

		"createTimestamp")
		unset LINE
		;;

		"entryCSN")
		unset LINE
		;;


		"modifiersName")
		unset LINE
		;;

		"modifyTimestamp")
		unset LINE
		;;

		esac

		echo "${LINE#:*}" >> $SCHEMADIR/${FILE#*\}}

	done < $FILE

done

printf "${SETCOLOR}Enabling generated Schemas${NOCOLOR}\n"

for FILE in $SCHEMADIR/*.ldif; do
	printf "${SETCOLOR}Adding $FILE.${NOCOLOR}\n"
	ldapadd -Y EXTERNAL -H ldapi:/// -f $FILE
done

printf "${SETCOLOR}Setting password for the config database${NOCOLOR}\n"

slappasswd > $WORKINGDIR/secrethash.txt
chmod 0400 $WORKINGDIR/secrethash.txt

cat << EOF > $WORKINGDIR/config_modify.ldif
# Modify directory database
dn: olcDatabase={1}mdb,cn=config
changeType: modify
delete: olcSuffix

dn: olcDatabase={1}mdb,cn=config
changeType: modify
add: olcSuffix
olcSuffix: $ROOTDN

dn: olcDatabase={1}mdb,cn=config
changeType: modify
delete: olcRootDN

dn: olcDatabase={1}mdb,cn=config
changeType: modify
add: olcRootDN
olcRootDN: cn=admin,$ROOTDN

dn: olcDatabase={1}mdb,cn=config
changeType: modify
delete: olcRootPW

dn: olcDatabase={1}mdb,cn=config
changeType: modify
add: olcRootPW
olcRootPW: $(cat $WORKINGDIR/secrethash.txt)

dn: olcDatabase={1}mdb,cn=config
changeType: modify
delete: olcDbIndex

dn: olcDatabase={1}mdb,cn=config
changeType: modify
add: olcDbIndex
olcDbIndex: uid pres,eq

dn: olcDatabase={1}mdb,cn=config
changeType: modify
add: olcDbIndex
olcDbIndex: cn,sn,mail pres,eq,approx,sub

dn: olcDatabase={1}mdb,cn=config
changeType: modify
add: olcDbIndex
olcDbIndex: objectClass eq

###########################################################
# REMOTE CONFIGURATION DEFAULTS
###########################################################
# Some defaults need to be added in order to allow remote
# access by DN cn=admin,cn=config to the LDAP config
# database. Otherwise only local root will
# administrative access.

dn: olcDatabase={0}config,cn=config
changetype: modify
add: olcRootDN
olcRootDN: cn=admin,cn=config

dn: olcDatabase={0}config,cn=config
changetype: modify
add: olcRootPW
olcRootPW: $(cat $WORKINGDIR/secrethash.txt)
EOF

printf "${SETCOLOR}Modifying password settings${NOCOLOR}\n"
ldapadd -Y EXTERNAL -H ldapi:/// -f $WORKINGDIR/config_modify.ldif


cat << EOF > $WORKINGDIR/base.ldif
# Tree root
dn: $ROOTDN
objectClass: top
objectClass: dcObject
objectClass: organization
o: $CARME_LDAP_DC1.$CARME_LDAP_DC2
dc: $CARME_LDAP_DC1
description: Tree root

# LDAP admin
dn: cn=admin,$ROOTDN
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: admin
userPassword: $(cat $WORKINGDIR/secrethash.txt)
description: LDAP administrator for $ROOTDN
EOF

printf "${SETCOLOR}adding base database${NOCOLOR}\n"
ldapadd -x -D cn=admin,$ROOTDN -W -f $WORKINGDIR/base.ldif


printf "${SETCOLOR}enable sasl${NOCOLOR}\n"
cat << EOF > $WORKINGDIR/sasl-digestmd5.ldif
###########################################################
# DEFAULTS MODIFICATION for SASL DIGEST-MD5
###########################################################
# Some of the defaults need to be modified in order to allow
# SASL supported access to the LDAP config.

# The LDAP administrator will need to tell the slapd server
# how to map an authentication request DN to a user's
# authentication DN. This is done by adding one or more
# olcAuthzRegexp attributes to the cn=config backend.
# This attribute takes two arguments:
#
# olcAuthzRegexp   <search pattern>   <replacement pattern>
#
# Please note, that more than one attribute can be specified.
# The LDAP server will serve them sequentially.

dn: cn=config
changetype: modify
add: olcAuthzRegexp
olcAuthzRegexp: uid=root,cn=[^,]*,cn=auth cn=admin,${ROOTDN}

# set the correct authentication policy
dn: cn=config
changetype: modify
add: olcAuthzPolicy
olcAuthzPolicy: to

# User passwords have to stored as cleartext within the
# LDAP directory
dn: olcDatabase={-1}frontend,cn=config
changetype: modify
add: olcPasswordHash
olcPasswordHash: {CLEARTEXT}
EOF

ldapadd -x -D cn=admin,cn=config  -W  -f $WORKINGDIR/sasl-digestmd5.ldif

systemctl restart slapd

ldapsearch -x

rm -r $WORKINGDIR

else
  echo "Sorry your Linux distribution is not supported in $CARME_VERSION."
  echo ""
  echo "For more information visit at www.open-carme.org or "
  echo "contact us via email at info@open-carme.org."
  echo ""
fi
