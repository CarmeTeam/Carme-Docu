#!/bin/bash
# script to install and configure slurm
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

SLURM_CONFIG_SAVE="./slurm_blanco.conf"
if [ ! -f $SLURM_CONFIG_SAVE ]; then
  printf "${SETCOLOR}${SLURM_CONFIG_SAVE} does not exist. Fatal error!${NOCOLOR}\n"
  exit 137
fi

SLURM_DBCONFIG_SAVE="./slurmdbd_blanco.conf"
if [ ! -f $SLURM_DBCONFIG_SAVE ]; then
  printf "${SETCOLOR}${SLURM_DBCONFIG_SAVE} does not exist. Fatal error!${NOCOLOR}\n"
  exit 137
fi
#-----------------------------------------------------------------------------------------------------------------------------------

if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then

  # install slurm packages on headnode ---------------------------------------------------------------------------------------------
  echo "install slurm packages on headnode"
  apt install -y libmunge-dev libmunge2 munge
  apt install -y slurmctld
  apt install -y slurmdbd
  apt install -y slurm-client
  apt install -y slurm-wlm-basic-plugins*
  echo ""
  #---------------------------------------------------------------------------------------------------------------------------------


  # create base configuration file -------------------------------------------------------------------------------------------------
  echo "create base configuration file"
  CARME_SLURM_CONFIG_FILE="/etc/slurm-llnl/slurm.conf"
  cp $SLURM_CONFIG_SAVE $CARME_SLURM_CONFIG_FILE


  #set slurm configs
  sed -i -e 's/ControlMachine=/ControlMachine='"$CARME_SLURM_ControlMachine"'/g' $CARME_SLURM_CONFIG_FILE

  if [[ ! -z "$CARME_SLURM_BackupController" ]]; then
    sed -i -e 's/#BackupController=/BackupController='"$CARME_SLURM_BackupController"'/g' $CARME_SLURM_CONFIG_FILE
  fi

  HELPER=${CARME_SLURM_SlurmctldPidFile//\//\\/}
  sed -i -e 's/SlurmctldPidFile=/SlurmctldPidFile='"$HELPER"'/g' $CARME_SLURM_CONFIG_FILE

  sed -i -e 's/SlurmctldPort=/SlurmctldPort='"$CARME_SLURM_SlurmctldPort"'/g' $CARME_SLURM_CONFIG_FILE

  HELPER=${CARME_SLURM_SlurmdPidFile//\//\\/}
  sed -i -e 's/SlurmdPidFile=/SlurmdPidFile='"$HELPER"'/g' $CARME_SLURM_CONFIG_FILE

  sed -i -e 's/SlurmdPort=/SlurmdPort='"$CARME_SLURM_SlurmdPort"'/g' $CARME_SLURM_CONFIG_FILE

  HELPER=${CARME_SLURM_SlurmdSpoolDir//\//\\/}
  sed -i -e 's/SlurmdSpoolDir=/SlurmdSpoolDir='"$HELPER"'/g' $CARME_SLURM_CONFIG_FILE

  sed -i -e 's/SlurmUser=/SlurmUser='"$CARME_SLURM_SlurmUser"'/g' $CARME_SLURM_CONFIG_FILE

  HELPER=${CARME_SLURM_StateSaveLocation//\//\\/}
  sed -i -e 's/StateSaveLocation=/StateSaveLocation='"$HELPER"'/g' $CARME_SLURM_CONFIG_FILE

  sed -i -e 's/AccountingStorageHost=/AccountingStorageHost='"$CARME_SLURM_AccountingStorageHost"'/g' $CARME_SLURM_CONFIG_FILE

  sed -i -e 's/SlurmctldDebug=/SlurmctldDebug='"$CARME_SLURM_SlurmctldDebug"'/g' $CARME_SLURM_CONFIG_FILE

  HELPER=${CARME_SLURM_SlurmctldLogFile//\//\\/}
  sed -i -e 's/SlurmctldLogFile=/SlurmctldLogFile='"$HELPER"'/g' $CARME_SLURM_CONFIG_FILE

  sed -i -e 's/SlurmdDebug=/SlurmdDebug='"$CARME_SLURM_SlurmdDebug"'/g' $CARME_SLURM_CONFIG_FILE

  HELPER=${CARME_SLURM_SlurmdLogFile//\//\\/}
  sed -i -e 's/SlurmdLogFile=/SlurmdLogFile='"$HELPER"'/g' $CARME_SLURM_CONFIG_FILE

  if [[ "$CARME_SLURM_Cgroups" = "yes" ]];then
    sed -i -e 's/#ProctrackType=proctrack\/cgroup/ProctrackType=proctrack\/cgroup/g' $CARME_SLURM_CONFIG_FILE
    sed -i -e 's/ProctrackType=proctrack\/pgid/#ProctrackType=proctrack\/pgid/g' $CARME_SLURM_CONFIG_FILE
    sed -i -e 's/#TaskPlugin=task\/cgroup/TaskPlugin=task\/cgroup/g' $CARME_SLURM_CONFIG_FILE
    sed -i -e 's/TaskPlugin=task\/none/#TaskPlugin=task\/none/g' $CARME_SLURM_CONFIG_FILE
    sed -i -e 's/#JobAcctGatherType=jobacct_gather\/cgroup/JobAcctGatherType=jobacct_gather\/cgroup/g' $CARME_SLURM_CONFIG_FILE
    sed -i -e 's/JobAcctGatherType=jobacct_gather\/linux/#JobAcctGatherType=jobacct_gather\/linux/g' $CARME_SLURM_CONFIG_FILE
  fi


  # add nodes to config file
  echo "#---------------" >> $CARME_SLURM_CONFIG_FILE
  echo "# COMPUTE NODES and PARTITIONS -----------------------------------------------------------------------------------------------------" >> $CARME_SLURM_CONFIG_FILE
  echo "#" >> $CARME_SLURM_CONFIG_FILE

  for NODE in $CARME_COMPUTENODES_1;
  do
    echo "NodeName=$NODE $CARME_SLURM_COMPUTENODES_CONFIG_1" >> $CARME_SLURM_CONFIG_FILE
  done
  echo "#" >> $CARME_SLURM_CONFIG_FILE

  if [[ ! -z "$CARME_COMPUTENODES_2" ]]; then
    for NODE in $CARME_COMPUTENODES_2;
    do
      echo "NodeName=$NODE $CARME_SLURM_COMPUTENODES_CONFIG_2" >> $CARME_SLURM_CONFIG_FILE
    done
    echo "#" >> $CARME_SLURM_CONFIG_FILE
  fi

  if [[ ! -z "$CARME_COMPUTENODES_3" ]]; then
    for NODE in $CARME_COMPUTENODES_3;
    do
      echo "NodeName=$NODE $CARME_SLURM_COMPUTENODES_CONFIG_3" >> $CARME_SLURM_CONFIG_FILE
    done
    echo "#" >> $CARME_SLURM_CONFIG_FILE
  fi


  # add default partitions
  echo "#---------------" >> $CARME_SLURM_CONFIG_FILE
  echo "# PARTITIONS -----------------------------------------------------------------------------------------------------------------------" >> $CARME_SLURM_CONFIG_FILE
  echo "#" >> $CARME_SLURM_CONFIG_FILE
  echo "$CARME_SLURM_PARITION_1" >> $CARME_SLURM_CONFIG_FILE
  echo "#" >> $CARME_SLURM_CONFIG_FILE

  if [[ ! -z "$CARME_SLURM_PARITION_2" ]]; then
    echo "$CARME_SLURM_PARITION_2" >> $CARME_SLURM_CONFIG_FILE
    echo "#" >> $CARME_SLURM_CONFIG_FILE
  fi

  if [[ ! -z "$CARME_SLURM_PARITION_3" ]]; then
    echo "$CARME_SLURM_PARITION_3" >> $CARME_SLURM_CONFIG_FILE
    echo "#" >> $CARME_SLURM_CONFIG_FILE
  fi

  echo "base slurm configuration file created and stored in /etc/slurm-llnl/"
  echo ""
  #---------------------------------------------------------------------------------------------------------------------------------


  # create db configuration file ---------------------------------------------------------------------------------------------------
  echo "create slurmdb configuration file"
  CARME_SLURM_CONFIG_FILE="/etc/slurm-llnl/slurmdb.conf"
  cp $SLURM_DBCONFIG_SAVE $CARME_SLURM_DBCONFIG_FILE

  sed -i -e 's/StoragePass=/StoragePass='"$CARME_SLURM_StoragePass"'/g' $CARME_SLURM_DBCONFIG_FILE
  sed -i -e 's/StorageUser=/StorageUser='"$CARME_SLURM_StorageUser"'/g' $CARME_SLURM_DBCONFIG_FILE

  echo "base slurmdb configuration file created and stored in /etc/slurm-llnl/"
  echo ""
  #---------------------------------------------------------------------------------------------------------------------------------


  # enable services on headnode ----------------------------------------------------------------------------------------------------
  echo "start and enable services on headnode"
  systemctl start munge
  systemctl enable munge
  systemctl start slurmctld
  systemctl enable slurmctld
  systemctl start slurmdbd
  systemctl enable slurmdbd
  echo ""
  #---------------------------------------------------------------------------------------------------------------------------------


  # install slurmd on all nodes ----------------------------------------------------------------------------------------------------
  echo "install slurmd on all nodes (this may take some time)"
  for NODE in $CARME_COMPUTENODES_1;
  do
    echo $NODE
    ssh root@${NODE} -X -t "apt install -y libmunge-dev libmunge2 munge"
    ssh root@${NODE} -X -t "apt install -y slurmd slurm-client slurm-wlm-basic-plugins libpam-slurm"
    scp /etc/munge/munge.key ${NODE}:/etc/munge/munge.key
    ssh root@${NODE} -X -t "systemctl start munge && systemctl enable munge"
    scp /etc/slurm-llnl/slurm.conf ${NODE}:/etc/slurm-llnl/slurm.conf
    ssh root@${NODE} -X -t "systemctl restart slurmd && systemctl restart munge"
    ssh root@${NODE} -X -t "systemctl enable slurmd"
    systemctl restart slurmctld
    systemctl restart munge
    scontrol reconfig
    sleep 5
  done

  if [[ ! -z "$CARME_COMPUTENODES_2" ]]; then
    for NODE in $CARME_COMPUTENODES_2;
    do
      echo $NODE
      ssh root@${NODE} -X -t "apt install -y libmunge-dev libmunge2 munge"
      ssh root@${NODE} -X -t "apt install -y slurmd slurm-client slurm-wlm-basic-plugins libpam-slurm"
      scp /etc/munge/munge.key ${NODE}:/etc/munge/munge.key
      ssh root@${NODE} -X -t "systemctl start munge && systemctl enable munge"
      scp /etc/slurm-llnl/slurm.conf ${NODE}:/etc/slurm-llnl/slurm.conf
      ssh root@${NODE} -X -t "systemctl restart slurmd && systemctl restart munge"
      ssh root@${NODE} -X -t "systemctl enable slurmd"
      systemctl restart slurmctld
      systemctl restart munge
      scontrol reconfig
      sleep 5
    done
  fi

  if [[ ! -z "$CARME_COMPUTENODES_3" ]]; then
    for NODE in $CARME_COMPUTENODES_3;
    do
      echo $NODE
      ssh root@${NODE} -X -t "apt install -y libmunge-dev libmunge2 munge"
      ssh root@${NODE} -X -t "apt install -y slurmd slurm-client slurm-wlm-basic-plugins libpam-slurm"
      scp /etc/munge/munge.key ${NODE}:/etc/munge/munge.key
      ssh root@${NODE} -X -t "systemctl start munge && systemctl enable munge"
      scp /etc/slurm-llnl/slurm.conf ${NODE}:/etc/slurm-llnl/slurm.conf
      ssh root@${NODE} -X -t "systemctl restart slurmd && systemctl restart munge"
      ssh root@${NODE} -X -t "systemctl enable slurmd"
      systemctl restart slurmctld
      systemctl restart munge
      scontrol reconfig
      sleep 5
    done
  fi
  echo ""
  #---------------------------------------------------------------------------------------------------------------------------------


  # create cluster in SLURM-DB -----------------------------------------------------------------------------------------------------
  echo "create cluster in SLURM-DB"
  sacctmgr add cluster $CARME_SLURM_ClusterName
  echo "now you can create accounts and users"
  echo ""
  #---------------------------------------------------------------------------------------------------------------------------------

  if [[ "$CARME_SLURM_Cgroups" = "yes" ]];then
    printf "${SETCOLOR}You want to use cgroups with SLURM on a Debian based system.${NOCOLOR}\n"
    printf "${SETCOLOR}Keep in mind that you have to adjust /etc/default/grub on ALL nodes!${NOCOLOR}\n\n"
  fi

  echo "SLURM configuration done"
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
