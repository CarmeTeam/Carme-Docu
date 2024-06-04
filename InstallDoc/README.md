# Installation documentation

If you have a suggestion or a question that is not resolved in this documentation, please contact the Carme Team: 

[carme@itwm.fraunhofer.de](carme@itwm.fraunhofer.de)

**Note:** The documentation provided here allows you to install **Carme-demo v0.99**. We do not recommend this installation in production-mode.

This documentation is divided in the following sections:

#### Basic options
1. [What is Carme-demo v0.99](#1-what-is-carme-demo-v099)
2. [System Requirements](#2-system-requirements)
3. [Features and next release](#3-features--next-release)
4. [How to install Carme-demo v0.99](#4-how-to-install-carme-demo-v099)
5. [How to uninstall Carme-demo v0.99](#5-how-to-uninstall-carme-demo-v099)

#### Advanced options
6. [How to modify the config file](#6-how-to-modify-the-config-file) 
7. [What to do if I want to use an already existing MySQL/MariaDB](#7-what-to-do-if-i-want-to-use-an-already-existing-mysqlmariadb)
8. [What to do if I want to use an already existing SLURM](#8-what-to-do-if-i-want-to-use-an-already-existing-slurm) 
9. [What to do if the install fails](#9-what-to-do-if-the-install-fails) 
10. [What to do if the uninstall fails](#10-what-to-do-if-the-uninstall-fails) 

##  1. What is Carme-demo v0.99
Carme-demo v0.99 is a simplified version of Carme v0.99. It excludes advanced features that are relevant in production mode. 

In detail:

|Features| Carme-demo v0.99| Carme v0.99 |
|--|--|--|
|LDAP| Not set | Required |
|Authentication| Not set | Login + 2FA|
|TLS| Not set (localhost)| Set |
|Multi-users| Not set (single-user)| Set |
|GPUs| Not set (CPUs only)| Set|
|IDEs/Tools | JupyterLab and Code-Server  | JupyterLab, Code-Server, GPI, and more |
| Cluster | supports 1 head-node and >1 compute-nodes | supports a login-node, a head-node, backup-nodes, and compute-nodes

## 2. System Requirements

For an optimal installation, your system must fulfill the following requirements:

- Distros: Ubuntu 20.04, 22.04, and Raspberry Pi OS. 

- Single devices
  - Laptops, Desktops, RPis, VMs using Linux or WSL (Windows Subsystem for Linux) 

- Clusters
  - Must include 1 head-node and >1 compute-nodes.
  - Direct SSH access from the head-node to the head-node must be set, i.e., no password or pasphrase is allowed, use SSH keys. 
  - Direct SSH access from the head-node to the compute-nodes must be set, i.e., no password or pasphrase is allowed, use SSH keys. 
  - Direct SSH access between the compute-nodes must be set, i.e., no passwords or passphrases are allowed, use SSH keys.
  - The head-node and the compute-nodes must share the `/home` and `/opt` directories, e.g., use NFS to set this.

## 3. Features & Next Release

**Carme-demo v0.99**:

- Can be installed in single devices and clusters.
- Is a single-user software stack (LDAP is not required).
- Does not include a TLS configuration. It is a localhost install. Access is granted via SSH tunnel.
- Is set to work with CPUs (GPU implementation is not included).
- Works without a login-node (in clusters, only 1 head-node is required)

**Carme-demo v1.0 (next release)**

- Is set to work with GPUs (CPUs and GPUs are implemented)
- Is a multi-user software stack (LDAP is installed)


## 4. How to install Carme-demo v0.99

Carme-demo is easy to install. Once your cluster is set with the [system requirements](#2-system-requirements), you are ready to go.

#### Step 1: Clone the repo

**Note:** The repo must be in the `/opt/Carme` directory.
- `cd /opt` (root user is required).
- `git clone -b demo-0.9.9 --single-branch https://github.com/CarmeTeam/Carme.git Carme` 

  **Note:** You are cloning the demo branch.

#### Step 2: Create the config file 

- `cd /opt/Carme`
- `bash config.sh` 

   **Note:** You don't need to modify the config file unless you are using an already existing MySQL/MariaDB or SLURM. To modify the config file, refer to [How to modify the config file](#6-how-to-modify-the-config-file).


#### Step 3: Run the installation script 

The installation script is made of 10 sub-scripts. To run them all, just follow (recommended): 
- `cd /opt/Carme`
- `bash start.sh` 

  **Note:** If the install fails, refer to [What to do if the install fails](#7-what-to-do-if-the-install-fails).


## 5. How to uninstall Carme-demo v0.99

Carme-demo is easy to remove. 
- If you chose to use an already existing MySQL/MariaDB, then we won't remove it, we will only remove the frontend database tables.
- If you chose to use an already existing SLURM, then we won't remove it, we will only remove Carme scritps. 

The uninstall script is made of 8 sub-scripts. To run them all, just follow (recommended): 
- `cd /opt/Carme`
- `bash end.sh`

  **Note:** If the uninstall fails, refer to [What to do if the uninstall fails](#8-what-to-do-if-the-uninstall-fails).



## 6. How to modify the config file

USER/ADMIN

- single user/admin info.

PASSWORDS 

- Modify the passwords if needed.

DATABASE 
- `CARME_DB="yes"` installs MySQL/MariaDB. `CARME_DB="no"` uses an already existing MySQL/MariaDB. If you choose to install MySQL/MariaDB, but you already have MySQL/MariaDB installed, then Carme will ask you if you want to reinstall the database management tool.
- `CARME_DB_SERVER="mysql"` uses MySQL. amd64 architectures use MySQL and arm64 architectures use MariaDB. If you prefer MariaDB in amd64, then consider `CARME_DB_SERVER="mariadb"`.
- `CARME_DB_DEFAULT_ENGINE=django.db.backends.mysql`. Do not modify this variable. It is used by Carme-frontend.
- `CARME_DB_DEFAULT_NAME="webfrontend"`. Carme-frontend database name. If you are using an already existing MySQL/MariaDB, please check that the database name `webfrontend` is not used in a different project. If it is, then change the name. Note that Carme does **NOT** overwrite an existing `webfrontend` database. It will only add Carme tables to it. 
- `CARME_DB_DEFAULT_NODE="head-node"`. Head-node `hostname -s`. In single-devices it is `localhost`.
- `CARME_DB_DEFAULT_HOST="head-node"`. Head-node `hostname -s`. In single-devices it is `localhost`.
- `CARME_DB_DEFAULT_USER="django"`. User name to handle `webfrontend` database.
- `CARME_DB_DEFAULT_PORT=3306`. MySQL/MariaDB port where `webfrontend` exits. If you use a different port, then change it accordingly. 
- `CARME_DB_SLURM_ENGINE=django.db.backends.mysql`. Do not modify this variable. It is used by Carme-frontend.
- `CARME_DB_SLURM_NAME="slurm_acct_db"`. SLURM accounting database name. If you are using an already existing SLURM, then Carme will use your already existing `slurm_acct_db` database. Carme does **NOT** overwrite/modify an existing `slurm_acct_db` database, this is managed by SLURM only.
- `CARME_DB_SLURM_NODE="head-node"`. Head-node `hostname -s`. In single-devices it is `localhost`.
- `CARME_DB_SLURM_HOST="head-node"`. Head-node hostname `hostname -s`. In single-devices it is `localhost`.
- `CARME_DB_SLURM_USER="slurm"`. SLURM user name to handle `slurm_acct_db` database. If you are using an already existing SLURM, then this user is set in your SLURM configuration.
- `CARME_DB_SLURM_PORT=3306`. MySQL/MariaDB port where `slurm_acct_db` exists. If you use a different port, then change it accordingly. 

SLURM

- `CARME_SLURM="yes"` installs SLURM. `CARME_SLURM="no"` uses an already existing SLURM. If you choose to install SLURM, but you already have SLURM installed, then Carme will ask you if you want to reinstall the workload management tool.
- `CARME_SLURM_CLUSTER_NAME="mycluster"` is your SLURM cluster name. Choose the name that you want. If you are using an already existing SLURM, then your cluster name is given with `sacctmgr show cluster`.
- `CARME_SLURM_PARTITION_NAME="carme"` is your SLURM partition name. Choose the name that you want. If you are using an already existing SLURM, you may have more than one partition.
- `CARME_SLURM_ACCELERATOR_TYPE="cpu"` enforces Carme-demo to work with CPUs only. (GPUs will be inlcuded in the next Carme-demo release).
- `CARME_SLURM_SLURMCTLD_PORT=6817` is the SLURM controller port. If you use an already existing SLURM, this port may be different. Refer to `SlurmctldPort` in your `slurm.conf` to know you actual port.
- `CARME_SLURM_SLURMD_PORT=6818` is the SLURM daemon port. If you use an already existing SLURM, this port may be different. Refer to `SlurmdPort` in your `slurm.conf` to know you actual port.

VENDORS

- Vendors have been tested with the default versions; therefore, if you change the vendor versions, we do not guarantee that it will work. These vendors are installed in `/opt/Carme/Carme-Vendors`. If you have similar vendors already installed in your system, they won't interfere with Carme-Vendors. Carme-Vendors **must be installed** in your system.

## 7. What to do if I want to use an already existing MySQL/MariaDB

in development 

## 8. What to do if I want to use an already existing SLURM

in development

## 9. What to do if the install fails

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
- When your installation fails, the script exits with an error message pointing to the sub-script, e.g., `ERROR [install_certs.sh]: ...`.

- Each sub-script can be run multiple times. This is ideal for debugging. For example, if your error message points to `install_certs.sh`, then once you fix the issue you can continue with the installation at this point, i.e.:
  - `cd /opt/Carme/Carme-Install`
  - `bash install_certs.sh`

- If you don't know how to solve the error, please contact us at carme@itwm.fraunhofer.de.


## 10. What to do if the uninstall fails

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
- When your uninstall fails, the script exits with an error message pointing to the sub-script, e.g., `ERROR [remove_certs.sh]: ...`.

- Each sub-script can be run multiple times. This is ideal for debugging. For example, if your error message points to `remove_certs.sh`, then once you fix the issue you can continue with the uninstall at this point, i.e.:
  - `cd /opt/Carme/Carme-Install`
  - `bash remove_certs.sh`

- If you don't know how to solve the error, please contact us at carme@itwm.fraunhofer.de.