# Installation documentation

If you have a suggestion or a question that is not resolved in this documentation, please contact the Carme Team: 

[carme@itwm.fraunhofer.de](carme@itwm.fraunhofer.de)

**Note:** The documentation provided here allows you to install **Carme-demo**. We do not recommend this installation in production-mode.

This documentation is divided in the following sections:

#### Introduction 
- [What is Carme-demo](#what-is-carme-demo)
- [System requirements](#system-requirements)
- [Features and next release](#features--next-release)

#### Basic options

- [How to install Carme-demo](#how-to-install-carme-demo)
- [How to use Carme-demo](#how-to-use-carme-demo)
- [How to remove Carme-demo](#how-to-remove-carme-demo)

#### Advanced options

- [How to configure the config file](#how-to-configure-the-config-file) 
- [How to configure an already existing MySQL/MariaDB](#how-to-configure-an-already-existing-mysqlmariadb)
- [How to configure an already existing SLURM](#how-to-configure-an-already-existing-slurm) 
- [What to do if the install fails](#what-to-do-if-the-install-fails) 
- [What to do if the uninstall fails](#what-to-do-if-the-uninstall-fails) 

## What is Carme-demo

Carme-demo is a simplified version of Carme. It excludes advanced features that are relevant in production mode. 

In detail:

|Features| Carme-demo | Carme |
|--|--|--|
|LDAP| Not set | Required |
|Authentication| Not set | Login + 2FA|
|TLS| Not set (localhost)| Set |
|Multi-users| Not set (single-user)| Set |
|GPUs| Not set (CPUs only)| Set|
|IDEs/Tools | JupyterLab and Code-Server  | JupyterLab, Code-Server, GPI, and more |
| Cluster | supports 1 head-node and >1 compute-nodes | supports a login-node, a head-node, backup-nodes, and compute-nodes

## System requirements

For an optimal installation, your system must fulfill the following requirements:

- Linux Base Distribution
  - Ubuntu 20.04-focal, 22.04-jammy, and 24.04-noble.
  - Debian 10-buster, 11-bullseye, 12-bookworm.

- Single Devices
  - Laptops, Desktops, RPis, VMs using Linux or WSL (Windows Subsystem for Linux). 

- Clusters
  - Must include 1 head-node and >1 compute-nodes.
  - SSH access from the head-node to itself must be set for the root user, i.e., (`ssh localhost`). Neither password nor passphrase is allowed, use SSH keys. 
  - SSH access from the head-node to the compute-nodes must be set for the root user. Neither password nor passphrase is allowed, use SSH keys. 
  - SSH access between the compute-nodes must be set for the root user. Neither passwords nor passphrases are allowed, use SSH keys.
  - The head-node and the compute-nodes must share the `/home` and `/opt` directories, e.g., use NFS.
  
## Features & next release

**Carme-demo v0.99 (current version)**

- Is installed in single devices and clusters.
- Is a single-user software stack (LDAP is not required).
- Does not include a TLS configuration. It is a localhost install. Access is granted via SSH tunnel. Refer to: [How to use Carme-demo](#how-to-use-carme-demo).
- Is set to work with CPUs (GPU implementation is not included).
- Works without a login-node (in clusters, only 1 head-node is required).

**Carme-demo v1.0 (next release)**

- Is set to work with GPUs (CPUs and GPUs are implemented).


## How to install Carme-demo

Carme-demo is easy to install. Once your cluster is set with the [system requirements](#system-requirements), you are ready to go.

#### Step 1: Clone the repo

The repo must be in the `/opt/Carme` directory.
- `cd /opt` (root user is required).
- `git clone -b demo-0.9.9 --single-branch https://github.com/CarmeTeam/Carme.git Carme` 

  **Note:** You are cloning the demo branch.

#### Step 2: Create the config file 

- `cd /opt/Carme`
- `bash config.sh` 

   **Note:** You don't need to modify the config file unless you are using an already existing MySQL/MariaDB or SLURM. If you do, refer to:
     - [How to configure the config file](#how-to-configure-the-config-file).
     - [How to configure an already existing MySQL/MariaDB](#how-to-configure-an-already-existing-mysqlmariadb).
     - [How to configure an already existing SLURM](#how-to-configure-an-already-existing-slurm).


#### Step 3: Run the installation script 

- `cd /opt/Carme`
- `bash start.sh` 

  **Note:** If the install fails, refer to: [What to do if the install fails](#what-to-do-if-the-install-fails).


## How to use Carme-demo

- In single-devices or in the head-node, open a web browser and type `localhost:10443`.
- To remotely access Carme, use SSH tunnel. 
   - In your local machine type: `ssh <username>@<head-node IP> -NL 9999:localhost:10443`. 
   - In your local machine, open a web browser and type: `localhost:9999`. 
   

## How to remove Carme-demo

Carme-demo is easy to remove. 

- `cd /opt/Carme`
- `bash end.sh`

  **Note:** If the uninstall fails, refer to: [What to do if the uninstall fails](#what-to-do-if-the-uninstall-fails).
    - Carme-demo does **NOT** uninstall an already existing MySQL/MariaDB. It only removes the frontend database.
    - Carme-demo does **NOT** uninstall an already existing SLURM. It only removes Carme scripts.


## How to configure the config file

You can customize the config file, `CarmeConfig.start`, if needed.

USER/ADMIN
- `CARME_UID="1000"`. Linux user uid, i.e., `id -u ubuntu`.
- `CARME_USER="ubuntu"` Linux user.
- `CARME_HOME="/home/ubuntu"` Linux user home folder.
- `CARME_GROUP="ubuntu"`. Linux user group, i.e., `id -gn ubuntu`.
- `CARME_USERS="single"`. Single-user software stack. Do not modify this variable.
- `CARME_SYSTEM="multi"`. The system is a cluster. For single devices consider `CARME_SYSTEM="single"`.
- `CARME_TIMEZONE="Europe/Berlin"`. Choose your timezone, i.e., `timedatectl list-timezones`.


PASSWORDS 

To secure your system, modify the passwords.

- `CARME_PASSWORD_USER="usrpwd"`. Single-user software stack does not require this variable.
- `CARME_PASSWORD_MYSQL="mysqlpwd"`. MySQL root password.
- `CARME_PASSWORD_SLURM="slurmpwd"`. SLURM password to control the database `slurm_acct_db`.
- `CARME_PASSWORD_DJANGO="djangopwd"`. Carme-frontend password to control the database `webfrontend`.

DATABASE 
- `CARME_DB="yes"` installs MySQL/MariaDB. `CARME_DB="no"` uses an already existing MySQL/MariaDB. If you choose to install MySQL/MariaDB, but you already have MySQL/MariaDB installed, then Carme will ask you if you want to reinstall the database management tool.
- `CARME_DB_SERVER="mysql"` uses MySQL. amd64 architectures use MySQL. arm64 architectures use MariaDB. If you prefer MariaDB in amd64, then consider `CARME_DB_SERVER="mariadb"`.
- `CARME_DB_DEFAULT_ENGINE=django.db.backends.mysql`. Do not modify this variable. It is used by Carme-frontend.
- `CARME_DB_DEFAULT_NAME="webfrontend"`. Carme-frontend database name. If you are using an already existing MySQL/MariaDB, then check that the database name `webfrontend` is not used in a different project. If it is, then change the name. Note that Carme does **NOT** overwrite an existing `webfrontend` database. It will only add Carme tables to it. 
- `CARME_DB_DEFAULT_NODE="head-node"`. Head-node name, i.e., `hostname -s`. In single-devices it is `localhost`.
- `CARME_DB_DEFAULT_HOST="head-node"`. Head-node name, i.e., `hostname -s`. In single-devices it is `localhost`.
- `CARME_DB_DEFAULT_USER="django"`. User name to handle `webfrontend` database.
- `CARME_DB_DEFAULT_PORT=3306`. MySQL/MariaDB port where `webfrontend` exits. If you use a different port, then change it accordingly. 
- `CARME_DB_SLURM_ENGINE=django.db.backends.mysql`. Do not modify this variable. It is used by Carme-frontend.
- `CARME_DB_SLURM_NAME="slurm_acct_db"`. SLURM accounting database name. If you are using an already existing SLURM, then Carme will use your already existing `slurm_acct_db` database. Carme does **NOT** overwrite/modify your already existing database, this is managed by SLURM only.
- `CARME_DB_SLURM_NODE="head-node"`. Head-node name, i.e., `hostname -s`. In single-devices it is `localhost`.
- `CARME_DB_SLURM_HOST="head-node"`. Head-node name, i.e., `hostname -s`. In single-devices it is `localhost`.
- `CARME_DB_SLURM_USER="slurm"`. SLURM user name to handle `slurm_acct_db` database. If you are using an already existing SLURM, then this user is set in your SLURM configuration.
- `CARME_DB_SLURM_PORT=3306`. MySQL/MariaDB port where `slurm_acct_db` exists. If you use a different port, then change it accordingly. 

SLURM
- `CARME_SLURM="yes"` installs SLURM. `CARME_SLURM="no"` uses an already existing SLURM. If you choose to install SLURM, but you already have SLURM installed, then Carme will ask you if you want to reinstall the workload management tool.
- `CARME_SLURM_CLUSTER_NAME="mycluster"` is your SLURM cluster name. Choose the name that you want. If you are using an already existing SLURM, then your cluster name is given with `sacctmgr show cluster`.
- `CARME_SLURM_PARTITION_NAME="carme"` is your SLURM partition name. Choose the name that you want. If you are using an already existing SLURM, you may have more than one partition.
- `CARME_SLURM_ACCELERATOR_TYPE="cpu"` enforces Carme-demo to work with CPUs only. (GPUs will be included in the next Carme-demo release).
- `CARME_SLURM_SLURMCTLD_PORT=6817` is the SLURM controller port. If you use an already existing SLURM, this port may be different. Refer to `SlurmctldPort` in your `slurm.conf` to know you actual port.
- `CARME_SLURM_SLURMD_PORT=6818` is the SLURM daemon port. If you use an already existing SLURM, this port may be different. Refer to `SlurmdPort` in your `slurm.conf` to know you actual port.

  **Note:** Advanced SLURM features can be implemented manually. 

VENDORS

Mambaforge, Singularity, and Go are installed in `/opt/Carme/Carme-Vendors`, Traefik proxy is installed in the container image `opt/Carme/Carme-ContainerImage/Carme-Proxy-Container/proxy.sif`. If you have similar vendors in your system, they won't interfere with Carme-Vendors. Carme-Vendors **must be installed** in your system.

- `MAMBAFORGE_VERSION=23.11.0-0`. Go to https://github.com/conda-forge/miniforge/releases to choose a different mambaforge version.
- `SINGULARITY_VERSION=3.11.4`. Go to https://github.com/sylabs/singularity/releases to choose a different singularity version.
- `PROXY_VERSION=2.11.2`. Go to https://github.com/traefik/traefik/releases to choose a different traefik version.
- `GO_VERSION=1.20.6`. Go to https://go.dev/dl/ to choose a different go version.

FRONTEND
- `CARME_FRONTEND_KEY="3nb5&c!y0f&myadrbkp+v67m9ps8(+(!eksyq!5&5z&mlwx_=="`. Carme-frontend security key. To create a new one, go to https://djecrety.ir. Note that your key **must not contain** the character `"`.
- `CARME_FRONTEND_NODE="head-node"`. Head-node name, i.e., `hostname -s`. In single devices it is `localhost`.
- `CARME_FRONTEND_URL="localhost"`. Default URL. Do not modify this variable.
- `CARME_FRONTEND_IP="10.0.0.27"`. Head-node IP, i.e., `hostname -I`. In single devices it is `127.0.0.1`
- `CARME_FRONTEND_ID="Carme"`. Carme-frontend ID. Do not modify this variable.
- `CARME_FRONTEND_PORT=8888`. Carme-frontend port. If you are already using port ` 8888`, choose a different one.

BACKEND
- `CARME_BACKEND_NODE="head-node"`. Head-node name, i.e., `hostname -s`. In single devices it is `localhost`. 
- `CARME_BACKEND_PORT=56798` Carme-backend port. If you are already using port ` 56798`, choose a different one.

NODES
- `CARME_NODE_LIST="computenode1 computenode2"`. List of compute-nodes names, i.e., `hostname -s`. In single devices it is `localhost`.
- `CARME_NODE_FS="yes"`. Do not modify this variable.
- `CARME_NODE_SSHD="yes"`. Do not modify this variable. 
- `CARME_NODE_SSD_PATH="/scratch"`. Do not modify this variable.
- `CARME_NODE_TMP_PATH="/tmp"`. Do not modify this variable.

## How to configure an already existing MySQL/MariaDB

If you already have MySQL/MariaDB installed in your system, then in your config file you should have `CARME_DB=no`, meaning that you don't need to install the database management tool. 

1. Modify `CarmeConfig.start` variables. Refer to DATABASE variables in [How to configure the config file](#how-to-configure-the-config-file).
2. Add the following to `/etc/mysql/my.cnf`:
   ```
   [mysqld]
   innodb_buffer_pool_size=4096M
   innodb_log_file_size=64M
   innodb_lock_wait_timeout=900
   max_allowed_packet=16M
   port=3306 # use your port
   ```
    **Note:** The install script will stop if you need to manually add these parameters. If it doesn't stop, then this was added automatically by the installation script. 

## How to configure an already existing SLURM

Carme uses its own `PrologSlurmctld`, `Prolog`, `EpilogSlurmctld`, and `Epilog` files. These files are:
```
PrologSlurmctld=/opt/Carme/Carme-Scripts/slurm/job-scripts/slurmctld-prolog-scripts/prolog.sh

Prolog=/opt/Carme/Carme-Scripts/slurm/job-scripts/slurm-prolog-scripts/carme-node-prolog.sh

EpilogSlurmctld=/opt/Carme/Carme-Scripts/slurm/job-scripts/slurmctld-epilog-scripts/epilog.sh

Epilog=/opt/Carme/Carme-Scripts/slurm/job-scripts/slurm-epilog-scripts/carme-node-epilog.sh
```
If you use similar files, then:

**Case 1: Your SLURM does not support multiple prolog/epilog files**: You must manually modify your scripts to add Carme-scripts.

**Case 2: Your SLURM supports multiple prolog/epilog files**: Add Carme-scripts to your already existing directories. Note that if multiple prolog and/or epilog scripts are specified, they will run in reverse alphabetical order (z-a -> Z-A -> 9-0). As an example, let's consider the following:

In your `slurm.conf`, you have `PrologSlurmctld=/<your-path>/prolog.sh`. 

Then: 


1. In the head-node, copy the corresponding Carme script to your current directory. If needed, change the name, e.g., 

   `cp /opt/Carme/Carme-Scripts/slurm/job-scripts/slurmctld-prolog-scripts/prolog.sh /<your-path>/carme-prolog.sh`  
2. In the head-node, modify `slurm.conf` to accept multiple slurmctld prologs, i.e, your variable should read:
   ```
   PrologSlurmctld=/<your-path>/*
   ```
3. Copy `slurm.conf` to all your compute nodes.
4. `systemctl restart slurmctld` and `scontrol reconfig` in the head-node.
5. `systemctl restart slurmd` and `scontrol reconfig` in the compute-nodes.
5. Repeat the process for all Carme-scripts. You **must** include all 4 Carme-scripts.

## What to do if the install fails

The install is made of 10 sub-scripts that are run in order. You must not alter this order:

1. install_system.sh
2. install_database.sh
3. install_slurm.sh
4. install_vendors.sh
5. install_certs.sh
6. install_frontend.sh
7. install_backend.sh
8. install_base.sh
9. install_scripts.sh
10. install_proxy.sh

- These 10 sub-scripts are stored in `/opt/Carme/Carme-Install`.
- When your installation fails, the script exits with an error message pointing to the sub-script, e.g., `ERROR [install_certs.sh]: ...`. To continue with the installation, run the sub-script and follow the order, e.g.,
  - `cd /opt/Carme/Carme-Install`
  - `bash install_certs.sh`

- If you don't know how to solve the error, please contact us at carme@itwm.fraunhofer.de.


## What to do if the uninstall fails

The uninstall is made of 8 sub-scripts that are run in order. You must not alter this order:

1. remove_proxy.sh
2. remove_base.sh
3. remove_backend.sh
4. remove_frontend.sh
5. remove_certs.sh
6. remove_vendors.sh
7. remove_slurm.sh
8. remove_database.sh

- These 8 sub-scripts are stored in `/opt/Carme/Carme-Install`.
- When your uninstall fails, the script exits with an error message pointing to the sub-script, e.g., `ERROR [remove_certs.sh]: ...`. To continue with the uninstall, run the sub-script and follow the order, e.g.,
  - `cd /opt/Carme/Carme-Install`
  - `bash remove_certs.sh`

- If you don't know how to solve the error, please contact us at carme@itwm.fraunhofer.de.
