#!/bin/bash
# script to install singularity
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

if [[ ! " ${THIS_NODE_IPS[@]} " =~ " ${CARME_HEADNODE_IP} " ]]; then
  printf "${SETCOLOR}this is not the Headnode${NOCOLOR}\n"
  exit 137
fi
#-----------------------------------------------------------------------------------------------------------------------------------

if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then

  # install slurmd on all nodes ----------------------------------------------------------------------------------------------------
  echo "install singularity on all nodes (this may take some time)"
  for NODE in $CARME_COMPUTENODES_1;
  do
    echo $NODE
    ssh root@${NODE} -X -t "apt install -y singularity-container"
    sleep 2
  done

  if [[ ! -z "$CARME_COMPUTENODES_2" ]]; then
    for NODE in $CARME_COMPUTENODES_2;
    do
      echo $NODE
      ssh root@${NODE} -X -t "apt install -y singularity-container"
      sleep 2
    done
  fi

  if [[ ! -z "$CARME_COMPUTENODES_3" ]]; then
    for NODE in $CARME_COMPUTENODES_3;
    do
      echo $NODE
      ssh root@${NODE} -X -t "apt install -y singularity-container"
      sleep 2
    done
  fi
  echo ""
  #---------------------------------------------------------------------------------------------------------------------------------

  # install debootstrap on the buildnodes
  echo "install debootstrap on the buildnodes (needed to create images)"
  ssh root@${CARME_BUILDNODE_1} -X -t "apt install -y debootstrap"
  sleep 2

  if [[ ! -z "$CARME_BUILDNODE_2" ]]; then
    ssh root@${CARME_BUILDNODE_2} -X -t "apt install -y debootstrap"
    sleep 2
  fi

  if [[ ! -z "$CARME_BUILDNODE_3" ]]; then
    ssh root@${CARME_BUILDNODE_3} -X -t "apt install -y debootstrap"
    sleep 2
  fi

  echo "Singularity installation done."
  echo ""
  exit 0
else
  echo "Sorry your Linux distribution is not supported in $CARME_VERSION."
  echo ""
  echo "For more information visit at www.open-carme.org or "
  echo "contact us via email at info@open-carme.org."
  echo ""
  exit 0
fi
