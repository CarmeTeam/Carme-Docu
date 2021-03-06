# CarmeConfig
*Carme* has a central configuration file, located at
```
PATH_TO_CARME/CarmeConfig
```
## SECURITY WARNING
*CarmeConfig* contains very sensitve inforation like passwords. It should
* not be hosted on the login node
* only be readable by root

## NOTES
In order to make changes in *CarmeConfig* effective, one must:
* execute ``./deployCarmeConig.sh``
* restart frontend and/or backend servers if changes are in their domain 

## A sample *CarmeConfig*
```
#-----------------------------------------------------------------------------------------------------------------------------------
# CARME Global Config File
#
# no space between variable="test"!!!
#-----------------------------------------------------------------------------------------------------------------------------------


# version --------------------------------------------------------------------------------------------------------------------------
CARME_VERSION="r0.8.0"
#stable release: r0.8.0
#-----------------------------------------------------------------------------------------------------------------------------------


# CARME specific scripts -----------------------------------------------------------------------------------------------------------
CARME_SCRIPTS_PATH="/opt/Carme/Carme-Scripts"
#default: /opt/Carme/Carme-Scripts
#-----------------------------------------------------------------------------------------------------------------------------------


# infrastructure variables ---------------------------------------------------------------------------------------------------------
CARME_HEADNODE_IP=""
#e.g. 123.456.789.1

CARME_HEADNODE_NAME=""
#e.g. headnode

CARME_HEADNODEBACKUP_IP=""
#e.g. 123.456.789.2 [if not needed leave empty]

CARME_HEADNODEBACKUP_NAME=""
#e.g. headnode2 [if not needed leave empty]

CARME_LOGINNODE_IP=""
#e.g. 123.456.789.3

CARME_LOGINNODE_NAME=""
#e.g. login

CARME_NODES_LIST=""
#e.g. node01 node02 node03 ... [this contains ALL compute AND build nodes]

CARME_HARDWARE_NUM_GPUS=
#e.g. 100 [this is the total number of GPUs in the Cluster]
#has to be an integer number! (note: do not use double quotes)

CARME_GPU_TYPE=""
# comma separated list of GPU types. Names have to be the same as defined in SLURM!

CARME_GPU_DEFAULTS=""
# defines the by default allocated CPUs and MEM (in GB) according the GPU types
# it has to have the following form and be written in quotes:
# default:CPUs:MEM volta:CPUs:MEM titan:CPUs:MEM

CARME_DISTRIBUTED_FS=""
# define if there is a global distributed FS that can be used or not
# allowed values are: yes | no

CARME_TMPDIR="/tmp"
# define the base directory for temporary files and folder inside a job
# if you modify this variable make sure that the directory is available
# on the compute nodes

CARME_LOCAL_SSD_PATH=""
# define if there is a local SSD available on the compute nodes
# e.g. /scratch_for_jobs

CARME_START_SSHD=""
# define whether we want ssh connection the jobs or not
# possible values are "always|multi|never"
#-----------------------------------------------------------------------------------------------------------------------------------


# network specific variables -------------------------------------------------------------------------------------------------------
CARME_NETWORK_BASE=""
#e.g. 123.456.789.

CARME_GATEWAY=""
#e.g. 123.456.789.3
#-----------------------------------------------------------------------------------------------------------------------------------


# container specific variables -----------------------------------------------------------------------------------------------------
CARME_MESSAGE_PATH="/home/.CarmeScripts/Carme-Messages"
#default: /home/.CarmeScripts/Carme-Messages

CARME_BASE_MOUNTS=''
#e.g.
#-----------------------------------------------------------------------------------------------------------------------------------


# CARME backend specific variables -------------------------------------------------------------------------------------------------
CARME_BACKEND_DEBUG=
#True or False (note: do not use double quotes)

CARME_BACKEND_PATH="/opt/Carme/Carme-Backend/"
#default: /opt/Carme/Carme-Backend/

CARME_BACKEND_SERVER=""
#e.g. headnode

CARME_BACKEND_PORT=
#e.g. 99999 (note: do not use double quotes)
#-----------------------------------------------------------------------------------------------------------------------------------


# CARME specific SSL variables -----------------------------------------------------------------------------------------------------
CARME_SSL_C=""
#e.g. your country shortcuts

CARME_SSL_ST=""
#e.g. your state shortcuts

CARME_SSL_L=""
#e.g. your city

CARME_SSL_O=""
#e.g. your organization

CARME_SSL_OU=""
#e.g. your organizational unit

CARME_SSL_EMAIL_BASE=""
#e.g. @my-carme-cluster.institute.com
#-----------------------------------------------------------------------------------------------------------------------------------


# CARME proxy specific variables ---------------------------------------------------------------------------------------------------
CARME_PROXY_PATH_BACKEND=''
#e.g. '/opt/Carme/Carme-Proxy/'

CARME_PROXY_PATH_FRONTEND=''
#e.g. '/opt/traefik/'
#-----------------------------------------------------------------------------------------------------------------------------------


# CARME frontend variables ---------------------------------------------------------------------------------------------------------
CARME_URL=""
#e.g. my-carme-cluster.institute.com

CARME_TIMEZONE=""
#e.g. Europe/Berlin

CARME_FRONTEND_ID=""
#e.g. unique name for the frontend (needed when running multiple frontends)

CARME_FRONTEND_PATH="/opt/Carme/Carme-Frontend"
#default: /opt/Carme/Carme-Frontend

CARME_FRONTEND_DEBUG=
#True or False (note: do not use double quotes)

CARME_FRONTEND_KEY=''
#needs to be secret and different for each install

#Admin pannel
CARME_ADMIN_HEADER=""
#e.g.

CARME_ADMIN_SITE_NAME=""
#e.g.

CARME_ADMIN_SITE_INDEX=""
#e.g.

CARME_FRONTEND_LINK_PROXY=""
#e.g. https://my-proxy.my-carme-cluster.institute.com/

CARME_FRONTEND_LINK_MONITOR=""
#e.g. https://my-monitor.my-carme-cluster.institute.com/

CARME_FRONTEND_LINK_SWITCH="" 
#e.g. https://my-switch.my-carme-cluster.institute.com/

CARME_FRONTEND_LINK_LDAP=""
#e.g. https://my-ldap.my-carme-cluster.institute.com/

CARME_FRONTEND_LINK_MATTERMOST=""
#e.g. https://my-mattermost.my-carme-cluster.institute.com/

CARME_FRONTEND_LINK_DISCLAIMER=""
#link to your usage disclaimer

CARME_FRONTEND_LINK_PRIVACY=""
#link to your data privacy disclaimer

CARME_FRONTEND_LINK_ORGA_URL=""
#link to your university|department|institute|company

CARME_FRONTEND_LINK_ADMIN_CLUSTER_MONITOR=""
#e.g.

CARME_FRONTEND_LOGO_TOP_LEFT=""
#e.g. the logo of your department
#must bee in static

CARME_FRONTEND_LOGO_TOP_RIGHT_1=""
#e.g. the logo of your univerity

CARME_FRONTEND_LOGO_TOP_RIGHT_2=""
#e.g. the logo of some founding

CARME_FRONTEND_TITLE=""
#e.g.
#-----------------------------------------------------------------------------------------------------------------------------------


# database backend variables -------------------------------------------------------------------------------------------------------
CARME_DB_PORT=""
#e.g. mysql-default-port
 
CARME_DB_NODE=""
#e.g. headnode

CARME_DB_USER=""
#e.g. backend-user

CARME_DB_PW=""
#e.g.

CARME_DB_DB=""
#e.g. data base name
#-----------------------------------------------------------------------------------------------------------------------------------


# SLURM specific variables ---------------------------------------------------------------------------------------------------------
CARME_SLURM_CONFIG_FILE="/etc/slurm-llnl/slurm.conf"
#default: /etc/slurm-llnl/slurm.conf (for Debian based systems)

CARME_SLURM_ControlAddr=""
#e.g. 123.456.789.1

CARME_SLURM_BackupController=""
#e.g. headnode2

CARME_SLURM_ClusterName=""
#e.g. cluster
#-----------------------------------------------------------------------------------------------------------------------------------


# LDAP specific variables ----------------------------------------------------------------------------------------------------------
CARME_LDAP_DC1=""
#e.g. my-server

CARME_LDAP_DC2=""
#e.g. local

CARME_LDAP_ADMIN=""
#e.g. admin

CARME_LDAP_SERVER_IP=""
#e.g. 123.456.789.180

CARME_LDAP_SERVER_PW=""
#the password choosen for the LDAP DB

CARME_LDAP_BIND_DN=""
#combination of CARME_LDAP_ADMIN,CARME_LDAP_DC1 and CARME_LDAP_DC2

# note: if you need more or less groups edit /opt/Carme/Carme-Scripts/carme-ldap-add-user.sh
CARME_LDAPGROUP_1=""
#e.g. physics-admin

CARME_LDAPGROUP_ID_1=""
#e.g. 900

CARME_LDAPINSTANZ_1=""
#e.g. PHYSICS

CARME_LDAPGROUP_2=""
#e.g. physics-user

CARME_LDAPGROUP_ID_2=""
#e.g. 901

CARME_LDAPINSTANZ_2=""
#e.g. PHYSICS

CARME_LDAPGROUP_3=""
#e.g. bio-user

CARME_LDAPGROUP_ID_3=""
#e.g. 902

CARME_LDAPINSTANZ_3=""
#e.g. BIOLOGY

CARME_LDAPGROUP_4=""
#e.g. math-user

CARME_LDAPGROUP_ID_4=""
#e.g. 903

CARME_LDAPINSTANZ_4=""
#e.g. MATH

CARME_LDAPGROUP_5=""
#e.g. inf-user

CARME_LDAPGROUP_ID_5=""
#e.g. 904

CARME_LDAPINSTANZ_5=""
#e.g. INF

CARME_LDAP_DEFAULTPASSWD_FOLDER=""
#e.g. /root/defaultpasswords

CARME_LDAP_PASSWD_LENGTH=""
#default: 20

CARME_LDAP_PASSWD_BASESTRING=""
#default: a-zA-Z1-9#%+,-./:;!<=>@\^_
#adjust according to the restrictions in your university|institute|company
#-----------------------------------------------------------------------------------------------------------------------------------


# BeeGFS specific variables --------------------------------------------------------------------------------------------------------
CARME_BEEGFS_MGMTNODE=""
#e.g. beegfsmgmt

CARME_BEEGFS_MGMTNODE_IP=""
#e.g. 122.133.155.17

CARME_BEEGFS_METANODES=""
#e.g. meta01 meta02 meta03 ...

CARME_BEEGFS_STORAGENODES=""
#e.g. storage01 storage02 storage03 ...

CARME_BEEGFS_HOMEMOUNT_NODES=""
#e.g. node01 node02 node03 ...
#-----------------------------------------------------------------------------------------------------------------------------------


# Zabbix specific variables --------------------------------------------------------------------------------------------------------
CARME_ZABBIX_GRAPH_PATH="/opt/Carme/Carme-Frontend/Carme-Django/static/zabbix-graphs"
#default: /opt/Carme/Carme-Frontend/static/zabbix-graphs
#-----------------------------------------------------------------------------------------------------------------------------------


# MatterMost specific variables ----------------------------------------------------------------------------------------------------
CARME_MATTERMOST_TRIGGER=""
#yes or no

CARME_MATTERMOST_PATH=""
#e.g. /opt/mattermost

CARME_MATTERMOST_COMMAND=""
#mattermost or platform [depends on mattermost version]

CARME_MATTERMOST_EMAIL_BASE=""
#e.g. mymail.com

CARME_MATTERMOST_DEFAULT_TEAM=""
#note: do not use uppercases
#e.g. myteam [do not use uppercases]
#-----------------------------------------------------------------------------------------------------------------------------------
```
