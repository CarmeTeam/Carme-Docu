# Install and Configure SLURM

## Create mysql database for SLURM
First, we create a new mysql database that is used for SLURM accounting. It is assumed that the mysql root account is _root_.
Open the mysql database as root
```console
# mysql -u root
```
Enter the following lines to create the SLURM database.
```console
create database slurm_acct_db;
create user 'slurm'@'localhost';
set password for 'slurm'@'localhost' = password('slurmdbpasswd');
grant usage on *.* to 'slurm'@'localhost';
grant all privileges on slurm_acct_db.* to 'slurm'@'localhost';
flush privileges;
exit
```

A mysql database was created with the following parameters:
* name: **slurm_acct_db**
* db-user: **slurm**
* db-password: **slurmdbpasswd**
* hostname: **localhost**

**NOTE**: **Do not change** the above values of db-user and db-password, since the values as stated here are required by the **CarmeConfig** as **CARME_SLURM_StorageUser** and **CARME_SLURM_StoragePass**!


## Install and Configure SLURM on the headnode and all nodes
You can start the SLURM installation and configuration with
```console
# bash carme-install-and-configure-slurm.sh
```

**NOTE**: If you use _cgroups_ as specified by you in **CarmeConfig**, you have to edit _/etc/default/grub_ manually, since it is not done by the script (for more details about SLURM and cgroups on Debian based systems see [here](https://slurm.schedmd.com/cgroups.html)).

After those steps, SLURM is installed on the headnode and all the compute nodes, your cluster is created in the SLURM database and you are able to add users to SLURM.