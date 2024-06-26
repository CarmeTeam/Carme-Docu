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
- [How to access Carme-demo](#how-to-access-carme-demo)
- [How to use Carme-demo](#how-to-use-carme-demo)
- [How to remove Carme-demo](#how-to-remove-carme-demo)

#### Advanced options

- [How to customize the config file](#how-to-customize-the-config-file) 
- [How to configure an already existing MySQL/MariaDB](#how-to-configure-an-already-existing-mysqlmariadb)
- [How to configure an already existing SLURM](#how-to-configure-an-already-existing-slurm) 
- [What to do if the install fails](#what-to-do-if-the-install-fails) 
- [What to do if the uninstall fails](#what-to-do-if-the-uninstall-fails) 
- [How to install WSL in a Windows device](#how-to-install-wsl-in-a-windows-device) 
- [How to install Carme-demo in a Windows device considering a WSL test environment](#how-to-install-carme-demo-in-a-windows-device-considering-a-wsl-test-environment)
- [How to set SSH keys in a cluster](#how-to-set-ssh-keys-in-a-cluster)

## What is Carme-demo

Carme-demo is a simplified version of Carme. It excludes advanced features that are relevant in production mode. 

In detail:

|Features| Carme-demo | Carme |
|--|--|--|
|LDAP| Not set | Required |
|Authentication| Not set | Login + 2FA|
|TLS| Not set (localhost)| Set |
|Multi-users| Not set (single-user)| Set |
|Projects App | Not Set  | Set |
|Management Scripts | Not Set  | Set |
|GPUs| Not set (CPUs only)| Set|
|IDEs/Tools | JupyterLab and Code-Server  | JupyterLab, Code-Server, GPI, and more |
| Cluster | supports 1 head-node and >1 compute-nodes | supports a login-node, a head-node, backup-nodes, and compute-nodes

## System requirements

For an optimal installation, your system must fulfill the following requirements:

- Linux Base Distribution
  - Ubuntu 20.04-focal, 22.04-jammy, and 24.04-noble.
  - Debian 11-bullseye, 12-bookworm.

- Devices
  - Laptops, PCs, RPis, VMs using Linux or WSL. Windows users, refer to: [How to install Carme-demo in a Windows device considering a WSL test environment](#how-to-install-carme-demo-in-a-windows-device-considering-a-wsl-test-environment).

- Clusters
  - All nodes must have the same timezone.
  - In all nodes, the user must have the same user ID and group ID.
  - The cluster must include 1 head-node and >1 compute-nodes.
  - SSH access from the head-node to itself must be set for the root user. Neither password nor passphrase is allowed, use SSH keys. Refer to: [How to set SSH keys in a cluster](#how-to-set-ssh-keys-in-a-cluster).
  - SSH access from the head-node to the compute-nodes must be set for the root user. Neither password nor passphrase is allowed, use SSH keys. [How to set SSH keys in a cluster](#how-to-set-ssh-keys-in-a-cluster).  
  - The head-node and the compute-nodes must share the `/home` and `/opt` directories, e.g., use NFS.
  
## Features & next release

**Carme-demo v0.99 (current version)**

- Is installed in single devices and clusters.
- Is a single-user software stack (LDAP is not required).
- Does not include a TLS configuration. It is a localhost install. Access is granted via SSH tunnel. Refer to: [How to access Carme-demo](#how-to-access-carme-demo).
- Is set to work with CPUs (GPU implementation is not included).
- Works without a login-node (in clusters, only 1 head-node is required).

**Carme-demo v1.0 (next release)**

- Is set to work with GPUs (CPUs and GPUs are implemented). For more information, refer to our [Roadmap](https://github.com/CarmeTeam/Carme?tab=readme-ov-file#roadmap).


## How to install Carme-demo

Carme-demo is easy to install. Once your cluster  or your single device is set with the [system requirements](#system-requirements), you are ready to go. 

**Windows users:** 
- Require WSL, refer to:  [How to install WSL in a Windows device](#how-to-install-wsl-in-a-windows-device). Once installed, you can proceed with the steps given here. 
- if you already have WSL, but you don't want to use it to test Carme-demo, then you can create a test environment that can be easily removed. Refer to: [How to install Carme-demo in a Windows device considering a WSL test environment](#how-to-install-carme-demo-in-a-windows-device-considering-a-wsl-test-environment).

#### Step 1: Clone the repo 

As root user, in the terminal type (in clusters use the head-node):

```
git clone -b demo-0.9.9 --single-branch https://github.com/CarmeTeam/Carme.git /opt/Carme
```

**Note:** The repo must be cloned to the `/opt/Carme` directory.

#### Step 2: Create the config file 

```
cd /opt/Carme && bash config.sh
```

**Note:** You don't need to modify the config file unless you want to customize it or unless you are using an already existing MySQL/MariaDB or SLURM. For more details, refer to:

  - [How to configure an already existing MySQL/MariaDB](#how-to-configure-an-already-existing-mysqlmariadb).
  - [How to configure an already existing SLURM](#how-to-configure-an-already-existing-slurm).
  - [How to customize the config file](#how-to-customize-the-config-file).

#### Step 3: Run the installation script 

```
bash start.sh
```

  **Note:** If the install fails, refer to: [What to do if the install fails](#what-to-do-if-the-install-fails).


## How to access Carme-demo

- In single-devices or in the head-node, open a web browser and type:

  ```
  localhost:10443
  ```

- To remotely access Carme-demo, use SSH tunnel. In your remote device proceed as follows: 
   - Open the terminal and type: 
   
     ```
     ssh <username>@<IP> -NL 9999:localhost:10443
     ```
     
      **Note:** IP refers to the head-node or the single device IP.
   - Then, open the web browser and type: 
   
     ```
     localhost:9999
     ```

## How to use Carme-demo

Refer to the following link:

- [Carme-demo user documentation](https://docs.open-carme.org/UserDoc/Demo)


## How to remove Carme-demo

Carme-demo is easy to remove. In the terminal type (in clusters use the head-node):

```
cd /opt/Carme && bash end.sh
```

  **Note:** If the uninstall fails, refer to: [What to do if the uninstall fails](#what-to-do-if-the-uninstall-fails).

  - Carme-demo does **NOT** uninstall an already existing MySQL/MariaDB. It only removes the frontend database.

  - Carme-demo does **NOT** uninstall an already existing SLURM. It only removes Carme scripts.


## How to customize the config file

You can customize the config file, `/opt/Carme/CarmeConfig.start`, if needed. 

Below we show all the variables:

**USER/ADMIN**

|Variable|Definition|
|--|--|
|`CARME_UID="1000"`|Linux user uid, e.g., `id -u ubuntu`.|
|`CARME_USER="ubuntu"` |Linux user.|
|`CARME_HOME="/home/ubuntu"`|Linux user home folder.|
|`CARME_GROUP="ubuntu"`|Linux user group, e.g., `id -gn ubuntu`.|
|`CARME_USERS="single"`|Single-user software stack. Do not modify this variable.|
|`CARME_SYSTEM="multi"`|The system is a cluster. For single devices consider `CARME_SYSTEM="single"`.|
|`CARME_TIMEZONE="Europe/Berlin"`|Choose your timezone, i.e., `timedatectl list-timezones`.|


**PASSWORDS** 

|Variable|Definition|
|--|--|
|`CARME_PASSWORD_USER="usrpwd"`|Single-user software stack does not require this variable.|
|`CARME_PASSWORD_MYSQL="mysqlpwd"`|MySQL root password. Change this passsword if you use an already existing MySQL/MariaDB.|
|`CARME_PASSWORD_SLURM="slurmpwd"`|SLURM password to control the database `slurm_acct_db`. Change this password if you use an already existing SLURM.|
|`CARME_PASSWORD_DJANGO="djangopwd"`|Carme-frontend password to control the database `webfrontend`.|
 

**DATABASE**

|Variable|Definition|
|--|--|
|`CARME_DB="yes"`|Installs MySQL/MariaDB. `CARME_DB="no"` uses an already existing MySQL/MariaDB. If you choose to install MySQL/MariaDB, but you already have MySQL/MariaDB installed, then Carme will ask you if you want to reinstall the database management tool.|
|`CARME_DB_SERVER="mysql"`|Uses MySQL. amd64 architectures use MySQL. arm64 architectures use MariaDB. If you prefer MariaDB in amd64, then consider `CARME_DB_SERVER="mariadb"`.|
|`CARME_DB_DEFAULT_NAME="webfrontend"`| Carme-frontend database name. If you are using an already existing MySQL/MariaDB, then check that the database name `webfrontend` is not used in a different project. If it is, then change the name. Note that Carme does **NOT** overwrite an existing `webfrontend` database. It will only add Carme tables to it. |
|`CARME_DB_DEFAULT_NODE="head-node"`|Head-node name, i.e., `hostname -s`. In single-devices `CARME_DB_DEFAULT_NODE="localhost"`. If you are using an already existing MySQL/MariaDB, consider the hostname where your database server containing the webfrontend database is installed.|
|`CARME_DB_DEFAULT_HOST="head-node"`|Head-node name, i.e., `hostname -s`. In single-devices `CARME_DB_DEFAULT_HOST="localhost"`. If you are using an already existing MySQL/MariaDB, consider the hostname where your database server containing the webfrontend database is installed.|
|`CARME_DB_DEFAULT_USER="django"`|User name to handle `webfrontend` database.|
|`CARME_DB_DEFAULT_PORT=3306`|MySQL/MariaDB port where `webfrontend` exits. If you use a different port, then change it accordingly.|
|`CARME_DB_SLURM_NAME="slurm_acct_db"`|SLURM accounting database name. If you are using an already existing SLURM, then Carme will use your already existing `slurm_acct_db` database. Carme does **NOT** overwrite/modify your already existing database, this is managed by SLURM only.|
|`CARME_DB_SLURM_NODE="head-node"`|Head-node name, i.e., `hostname -s`. In single-devices `CARME_DB_SLURM_NODE="localhost"`. If you are using an already existing MySQL/MariaDB, consider the hostname where your database server containing the slurm_acct_db database is installed.|
|`CARME_DB_SLURM_HOST="head-node"`|Head-node name, i.e., `hostname -s`. In single-devices `CARME_DB_SLURM_HOST="localhost"`. If you are using an already existing MySQL/MariaDB, consider the hostname where your database server containing the slurm_acct_db database is installed.|
|`CARME_DB_SLURM_USER="slurm"`|SLURM user name to handle `slurm_acct_db` database. If you are using an already existing SLURM, then this user is set in your SLURM configuration.|
|`CARME_DB_SLURM_PORT=3306`|MySQL/MariaDB port where `slurm_acct_db` exists. If you use a different port, then change it accordingly. |

**SLURM**

**Note:** Advanced SLURM features can be implemented manually. 

|Variable|Definition|
|--|--|
|`CARME_SLURM="yes"`|Installs SLURM. `CARME_SLURM="no"` uses an already existing SLURM. If you choose to install SLURM, but you already have SLURM installed, then Carme will ask you if you want to reinstall the workload management tool.|
|`CARME_SLURM_CLUSTER_NAME="mycluster"`| Is your SLURM cluster name. Choose the name that you want. If you are using an already existing SLURM, then your cluster name is given with `sacctmgr show cluster`.|
|`CARME_SLURM_PARTITION_NAME="carme"`| Is your SLURM partition name. Choose the name that you want. If you are using an already existing SLURM, you may have more than one partition.|
|`CARME_SLURM_ACCELERATOR_TYPE="cpu"`|Enforces Carme-demo to work with CPUs only. (GPUs will be included in the next Carme-demo release).|
|`CARME_SLURM_SLURMCTLD_PORT=6817`|Is the SLURM controller port. If you use an already existing SLURM, this port may be different. Refer to `SlurmctldPort` in your `slurm.conf` to know you actual port.|  
|`CARME_SLURM_SLURMD_PORT=6818`|Is the SLURM daemon port. If you use an already existing SLURM, this port may be different. Refer to `SlurmdPort` in your `slurm.conf` to know you actual port.|



**VENDORS**

**Note:** Mambaforge, Singularity, and Go are installed in `/opt/Carme/Carme-Vendors`, Traefik proxy is installed in the container image `opt/Carme/Carme-ContainerImage/Carme-Proxy-Container/proxy.sif`. If you have similar vendors in your system, they won't interfere with Carme-Vendors. Carme-Vendors **must be installed** in your system.

|Variable|Definition|
|--|--|
|`MAMBAFORGE_VERSION=23.11.0-0`|Go to [https://github.com/conda-forge/miniforge/releases](https://github.com/conda-forge/miniforge/releases) to choose a different mambaforge version.|
|`SINGULARITY_VERSION=3.11.4`|Go to [https://github.com/sylabs/singularity/releases](https://github.com/sylabs/singularity/releases) to choose a different singularity version.|
|`PROXY_VERSION=2.11.2`|Go to [https://github.com/traefik/traefik/releases](https://github.com/traefik/traefik/releases) to choose a different traefik version.|
|`GO_VERSION=1.20.6`|Go to [https://go.dev/dl/](https://go.dev/dl/) to choose a different go version.|

**FRONTEND**

|Variable|Definition|
|--|--|
|`CARME_FRONTEND_KEY="..."`|Carme-frontend security key. To create a new one, go to [https://djecrety.ir](https://djecrety.ir). Note that your key **must not contain** the character `"`.|
|`CARME_FRONTEND_NODE="head-node"`|Head-node name, i.e., `hostname -s`. In single devices `CARME_FRONTEND_NODE="localhost"`.|
|`CARME_FRONTEND_URL="localhost"`|Default URL. Do not modify this variable.|
|`CARME_FRONTEND_IP="10.0.0.27"`|Head-node IP, i.e., `hostname -I`. In single devices `CARME_FRONTEND_IP="127.0.0.1"`.|
|`CARME_FRONTEND_ID="Carme"`|Carme-frontend ID. Do not modify this variable.|
|`CARME_FRONTEND_PORT=8888`|Carme-frontend port. If you are already using port ` 8888`, choose a different one.|

**BACKEND**

|Variable|Definition|
|--|--|
|`CARME_BACKEND_NODE="head-node"`|Head-node name, i.e., `hostname -s`. In single devices `CARME_BACKEND_NODE="localhost"`.|
|`CARME_BACKEND_PORT=56798`|Carme-backend port. If you are already using port ` 56798`, choose a different one.| 

**NODES**

|Variable|Definition|
|--|--|
|`CARME_NODE_LIST="cnode1 cnode2"`|List of compute-nodes names, i.e., `hostname -s`. In single devices `CARME_NODE_LIST="localhost"`.|
|`CARME_NODE_FS="yes"`|Do not modify this variable.|
|`CARME_NODE_SSHD="yes"`|Do not modify this variable. |
|`CARME_NODE_SSD_PATH="/scratch"`|Creates a scratch directory. Do not modify this variable.|
|`CARME_NODE_TMP_PATH="/tmp"`| Uses the tmp directory. Do not modify this variable.|

## How to configure an already existing MySQL/MariaDB

If you already have MySQL/MariaDB installed in your system, then:

1. Modify/Check the following `CarmeConfig.start` variables:

   - `CARME_PASSWORD_MYSQL="mysqlpwd"`
   - `CARME_DB="no"`
   - `CARME_DB_SERVER="mysql"`
   - `CARME_DB_DEFAULT_NAME="webfrontend"`
   - `CARME_DB_DEFAULT_NODE="head-node"`
   - `CARME_DB_DEFAULT_HOST="head-node"`
   - `CARME_DB_DEFAULT_PORT=3306`

   **Note:** To know how to modify these variables, refer to [How to customize the config file](#how-to-customize-the-config-file). 

2. Add the following to `/etc/mysql/my.cnf`:

   ```
   [mysqld]
   innodb_buffer_pool_size=4096M
   innodb_log_file_size=64M
   innodb_lock_wait_timeout=900
   max_allowed_packet=16M
   port=3306 # use your port
   ```
3. Run the installation script, i.e., `bash start.sh`.

## How to configure an already existing SLURM

If you already have SLURM installed in your system, then:

1. Modify/Check the following `CarmeConfig.start` variables:

   - `CARME_PASSWORD_SLURM="slurmpwd"`
   - `CARME_DB_SLURM_NAME="slurm_acct_db"`
   - `CARME_DB_SLURM_NODE="head-node"`
   - `CARME_DB_SLURM_HOST="head-node"` 
   - `CARME_DB_SLURM_USER="slurm"`
   - `CARME_DB_SLURM_PORT=3306`
   - `CARME_SLURM="no"`
   - `CARME_SLURM_CLUSTER_NAME="mycluster"`
   - `CARME_SLURM_PARTITION_NAME="carme"`
   - `CARME_SLURM_ACCELERATOR_TYPE="cpu"`
   - `CARME_SLURM_SLURMCTLD_PORT=6817`
   - `CARME_SLURM_SLURMD_PORT=6818`

   **Note:** To know how to modify these variables, refer to [How to customize the config file](#how-to-customize-the-config-file).

2. If you use prolog and epilog files in your `slurm.conf`, then you must add Carme-prologs and epilogs to your already existing directories:

   Carme uses its own `PrologSlurmctld`, `Prolog`, `EpilogSlurmctld`, and `Epilog` files. These files are stored in `/opt/Carme/Carme-Scripts/slurm/job-scripts/*`:

   ```
   PrologSlurmctld=/opt/Carme/Carme-Scripts/slurm/job-scripts/slurmctld-prolog-scripts/prolog.sh

   Prolog=/opt/Carme/Carme-Scripts/slurm/job-scripts/slurm-prolog-scripts/carme-node-prolog.sh

   EpilogSlurmctld=/opt/Carme/Carme-Scripts/slurm/job-scripts/slurmctld-epilog-scripts/epilog.sh

   Epilog=/opt/Carme/Carme-Scripts/slurm/job-scripts/slurm-epilog-scripts/carme-node-epilog.sh
   ```

   To add them, proceed as follows:

   **Case 1: Your SLURM version does not support multiple prolog/epilog files**: You must manually modify your scripts to add Carme-scripts.

   **Case 2: Your SLURM version supports multiple prolog/epilog files**: Add Carme-scripts to your already existing directories. Note that if multiple prolog and/or epilog scripts are specified, they will run in reverse alphabetical order (z-a -> Z-A -> 9-0). As an example, let's consider the following:

   In your `slurm.conf`, you have `PrologSlurmctld=/<your-path>/prolog.sh`. 

   Then: 


   1. In the head-node, copy the corresponding Carme script to your current directory. If needed, change the name, e.g., 
      ```
      cp /opt/Carme/Carme-Scripts/slurm/job-scripts/slurmctld-prolog-scripts/prolog.sh /<your-path>/carme-prolog.sh
      ```
        
   
   2. In the head-node, modify `slurm.conf` to accept multiple slurmctld prologs, i.e, your variable should read:
   
      ```
      PrologSlurmctld=/<your-path>/*
      ```

   3. Copy `slurm.conf` to all your compute nodes.
   4. `systemctl restart slurmctld && scontrol reconfig` in the head-node.
   5. `systemctl restart slurmd && scontrol reconfig` in the compute-nodes.
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
- When your installation fails, the script exits with an error. You can identify to which sub-script the error is related. Once fixed, you can rerun `start.sh` or you can continue with the installation running the sub-script and following the order, e.g., if the install stopped at `install_certs.sh`, then:

  ```
  cd /opt/Carme/Carme-Install && bash install_certs.sh
  ```
  

  **Note:** Carme-demo install scripts can be run multiple times.

- If you don't know how to solve the error, please contact us at [carme@itwm.fraunhofer.de](carme@itwm.fraunhofer.de).


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
- When your uninstall fails, the script exits with an error. You can identify to which sub-script the error is related. Once fixed, you can rerun `end.sh` or you can continue with the uninstall running the sub-script and following the order, e.g., if the uninstall stopped at `remove_certs.sh`, then:

  ```
  cd /opt/Carme/Carme-Install && bash remove_certs.sh
  ```

  **Note:** Carme-demo uninstall scripts can be run multiple times.

- If you don't know how to solve the error, please contact us at [carme@itwm.fraunhofer.de](carme@itwm.fraunhofer.de).

## How to install WSL in a Windows device

Open the Windows PowerShell and type:

```
wsl --install
```
**Note:** By default, **Ubuntu** Linux is installed. 

In the process you will be asked to:

```
Enter new UNIX username:
password:
```

Once the installation completes, you have access to the Ubuntu terminal. If you open a new PowerShell, type `wsl.exe` to access the Ubuntu terminal. 

To install Carme-demo, you must be a root user. In the terminal type:

```
sudo su 
```

Carme is installed in the `/opt` directory, then:

```
cd /opt
```
Now, you are ready to clone the repo and install Carme-demo. Follow the steps given in [How to install Carme-demo](#how-to-install-carme-demo).

If you don't want to install Carme-demo in your active WSL, you can create a test environment considering a separate WSL distribution. Refer to: [How to install Carme-demo in a Windows device considering a WSL test environment](#how-to-install-carme-demo-in-a-windows-device-considering-a-wsl-test-environment).

## How to install Carme-demo in a Windows device considering a WSL test environment

e.g., choose one of the following versions:

- [Ubuntu 20.04 test environment](#ubuntu-2004-test-environment)
- [Ubuntu 22.04 test environment](#ubuntu-2204-test-environment)

### Ubuntu 20.04 test environment

Open the Windows PowerShell. 

To download the WSL tar file for Ubuntu 20.04, type:

```
Invoke-WebRequest https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64-wsl.rootfs.tar.gz -OutFile ubuntu-20.04-server-cloudimg-amd64-wsl.rootfs.tar.gz
```

Import the tar file as a new Ubuntu distribution:

```
wsl --import carme-ubuntu20.04 carme-ubuntu20.04 ubuntu-20.04-server-cloudimg-amd64-wsl.rootfs.tar.gz
```
Delete the tar file:

```
Remove-Item -Recurse ubuntu-20.04-server-cloudimg-amd64-wsl.rootfs.tar.gz
```

Access the terminal of the new Ubuntu distribution:

```
wsl -d carme-ubuntu20.04
```

Now you are in the Ubuntu terminal, enable systemd and then exit back to the PowerShell:

```
cat << 'EOF' >> /etc/wsl.conf
[boot]
systemd=true
EOF
exit
```

In the PowerShell, restart the new distribution:

```
wsl --terminate carme-ubuntu20.04
wsl -d carme-ubuntu20.04
```

Now you are back to the Ubuntu terminal. Add a new user (in this example the new user is `ubuntu`):

```
adduser --gecos "" --disabled-password ubuntu
echo "ubuntu:password" | chpasswd
```

Clone the repository to the `/opt/Carme` directory:

```
git clone -b demo-0.9.9 --single-branch https://github.com/CarmeTeam/Carme.git /opt/Carme
```

Change into the `/opt/Carme` directory and then start the installation:

```
cd /opt/Carme/ && bash start.sh
```

Once the installation is finished, you can access Carme-demo. Open a browser and type in the URL box:
```
localhost:10443
```

If the installation fails, refer to: [What to do if the install fails](#what-to-do-if-the-install-fails).
 
To test Carme-demo, refer to: [How to use Carme-demo](#how-to-use-carme-demo). Once you finish testing Carme-demo, you can discard the distribution:

```
wsl --terminate carme-ubuntu20.04
wsl --unregister carme-ubuntu20.04
Remove-Item -Recurse carme-ubuntu20.04
```
If you like Carme-demo, you can install it in your main WSL distribution. In the PoweShell type `wsl.exe` and follow the steps given in: [How to install Carme-demo](#how-to-install-carme-demo). 

### Ubuntu 22.04 test environment

Open the Windows PowerShell. 

To download the WSL tar file for Ubuntu 22.04, type:
  
   ```
   Invoke-WebRequest https://cloud-images.ubuntu.com/wsl/releases/22.04/current/ubuntu-jammy-wsl-amd64-wsl.rootfs.tar.gz -OutFile ubuntu-jammy-wsl-amd64-wsl.rootfs.tar.gz
   ```
Import the tar file as a new Ubuntu distribution:

```
wsl --import carme-ubuntu22.04 carme-ubuntu22.04 ubuntu-jammy-wsl-amd64-wsl.rootfs.tar.gz
```
Delete the tar file:

```
Remove-Item -Recurse ubuntu-jammy-wsl-amd64-wsl.rootfs.tar.gz
```

Access the terminal of the new Ubuntu distribution:

```
wsl -d carme-ubuntu22.04
```

Now you are in the Ubuntu terminal, enable systemd and then exit back to the PowerShell:

```
cat << 'EOF' >> /etc/wsl.conf
[boot]
systemd=true
EOF
exit
```
In the PowerShell, restart the new distribution:

```
wsl --terminate carme-ubuntu22.04
wsl -d carme-ubuntu22.04
```

Now you are back to the Ubuntu terminal. Add a new user (in this example the new user is `ubuntu`):

```
adduser --gecos "" --disabled-password ubuntu
echo "ubuntu:password" | chpasswd
```

Clone the repository to the `/opt/Carme` directory:

```
git clone -b demo-0.9.9 --single-branch https://github.com/CarmeTeam/Carme.git /opt/Carme
```

Change into the `/opt/Carme` directory and then start the installation:

```
cd /opt/Carme/ && bash start.sh
```

Once the installation is finished, you can access Carme-demo. Open a browser and type in the URL box:

```
localhost:10443
```

If the installation fails, refer to: [What to do if the install fails](#what-to-do-if-the-install-fails).
 
To test Carme-demo, refer to: [How to use Carme-demo](#how-to-use-carme-demo). Once you finish testing Carme-demo, you can discard the distribution:

```
wsl --terminate carme-ubuntu22.04
wsl --unregister carme-ubuntu22.04
Remove-Item -Recurse carme-ubuntu22.04
```

If you like Carme-demo, you can install it in your main WSL distribution. In the PoweShell type `wsl.exe` and follow the steps given in: [How to install Carme-demo](#how-to-install-carme-demo). 


## How to set SSH keys in a cluster

Let's consider that your cluster is made of 1 head-node a 2 compute-nodes.
In each node, `hostname -s` and `hostname -I` gives, e.g.,

|node|`hostname -s`| `hostname -I`|
|--|--|--|
|head node| carmec0| 10.0.0.1|
|compute node 1| carmec1| 10.0.0.10|
|compute node 2| carmec2| 10.0.0.11|

#### Step 1: Modify `/etc/hosts` 
In the head node, `/etc/hosts` should have:

```
127.0.0.1       localhost
127.0.1.1       carmec0

10.0.0.1        carmec0
10.0.0.10       carmec1
10.0.0.11       carmec2
```

In the compute node 1, `/etc/hosts` should have:

```
127.0.0.1       localhost
127.0.1.10      carmec1

10.0.0.1        carmec0
10.0.0.10       carmec1
10.0.0.11       carmec2
```

And in the compute node 2, `/etc/hosts` should have:

```
127.0.0.1       localhost
127.0.1.1       carmec2

10.0.0.1        carmec0
10.0.0.10       carmec1
10.0.0.11       carmec2
```

#### Step 2: Create the SSH keys

In the head node, type:
```
ssh-keygen -t ed25519 -N="" -C "root@carmec0"
```

This creates your passphraseless ssh key in  `/root/.ssh/`. Open the `.pub` key, i.e.,
```
cat id_ed25519.pub
```

Copy the output to `/root/.ssh/authorized_keys` in the head-node.

Copy the output to `/root/.ssh/authorized_keys` in the compute-nodes.

**Congratulations!** Now you can ssh from the head-node to itself considering `ssh carmec0` and `ssh localhost`, and from the head-node to the compute-nodes considering `ssh carmec1` and `ssh carmec2`.
