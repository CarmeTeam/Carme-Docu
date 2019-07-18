# Install NOTES
* **WARNING**: The *Carme* install process is still in an ***alpha*** stage. We are working hard on a integrated install process for heterogenious HPC setups. As of now, *Carme* installation has only been tested on a few systems which where all ***DEBIAN*** based.

* **NOTE**: please feel free to open issues if the current documentation is not complete ...

### System requirements
In order to install *Carme*, you should have the following basic setup:
#### Hardware
* **Login Node** - simple CPU machine that is connected to where ever your users are comming from. This will run the web-frontend.
* **Head Node** - simple CPU machine, connected to the internals of your HPC system (FS, Batch System)
* Several **Compute Nodes** - powerfull (multi)-GPU machines
* Fast interconnects between head and compute nodes

#### Software
* Parallel File System (connecting workers and head-node) -> we recommend our [BeeGFS](https://www.beegfs.io/content/)
* An **MySQL** DB-Server some in your system (reachable from login and head)
* **Apache2** Webserver running on login
* **Python3** environment on login and headnode (we recomend to use [anaconda](https://www.anaconda.com/distribution/)

### Using existing HPC Setups
If you are already running an HPC system with a parallel FS and ***Slurm***, you can simply add *Carme* on top of this setup. We recomend to create new *Slurm* partitions for *Carme*.

### Things *Carme* can't do (yet)
* **heterogeneous compute nodes**: currently, *Carme* assumes that all nodes have an identical hardware setup. This will be fixed in upcoming releases.
* *Carme* currently only supports the ***Slurm*** batch system.
* Running *Carme* in **non Debian** Linux is possible, but not tested very well. Most install scripts will fail...


## Install Components needed by Carme
In order to run and use Carme you have to install and configure some components. In each of the folder you find either scripts that do most of the basic installations for you and READMEs that provide instructions and/or additional information.

Before you continue make sure that the entire **Carme** repository is located in **/opt** of your headnode and that it is mounted on all nodes within your cluster. 

`` git clone https://github.com/CarmeTeam/Carme.git ``

Additionally, put **_/opt/Carme/Carme-Frontend_** on the loginnode, where you want to run the carme-webfrontend on.

### First Step
Before you run any of the scripts, make sure that you edited **CarmeConfig** (see [CarmeConfig Docs](../CarmeConfig.md) according to your needs. This is essential as each script here (and later in productive mode) depents on **CarmeConfig**.
In order to create **CarmeConfig** you can copy the CarmeConfig_blanco to a new CarmeConfig
```console
# cp /opt/Carme/CarmeConfig_blanco /opt/Carme/CarmeConfig
```
Then you edit CarmeConfig using e.g. vim
```console
# vim /opt/Carme/CarmeConfig
```
Note that inside the file are example (and or default) values for each variable that is defined in CarmeConfig.
After everything is configured you should make the file only accessible to root
```console
# chmod 600 /opt/Carme/CarmeConfig
```

### Second Step
The next steps depend on your needs. If you start from scratch you find here scripts an additional information to install

* [LDAP](Carme-Install-LDAP) (user authentication)
* [SLURM](Carme-Install-Slurm) (scheduler)
* [Singularity](Carme-Install-Singularity) (container solution)
* [Zabbix](Carme-Install-Zabbix) (monitoring)
* [Mattermost](Carme-Install-Mattermost) (self-hosted chat program)

For LDAP, SLURM and Singularity we provide scripts that do the basic installation and configuration for you, so that get a good starting point. For Zabbix and Mattermost we recommend to follow their installation and configuration instructions (links can be found in the respective folders).

### Third Step
There are a few scripts that should be added to your **crontab**. For more information have a look at the respective documentaion.

#### headnode
* getZabbixGraphs.sh
```bash
* * * * * root /bin/bash /opt/Carme/Carme-Scripts/frontend/getZabbixGraphs.sh
```
* carme-empty-trash.sh (note that deleting a file/folder in JupyterLab put the file in .local/Thrash but does not delete the files!)
```bash
30 19 * * 6 root /bin/bash /opt/Carme/Carme-Scripts/maintenance/carme-empty-trash.sh
```
* carme-backup-home-and-mattermost.sh (optional; see documentation)
```bash
30 23 * * 6 root /bin/bash /opt/Carme/Carme-Scripts/maintenance/carme-backup-home-and-mattermost.sh
```

#### compute nodes
* carme-find-ghost-jobs-notify.sh (see documentation)
```bash
*/5 * * * * root /bin/bash /opt/Carme/Carme-Scripts/maintenance/carme-find-ghost-jobs-notify.sh
```
* carme-check-home.sh (needs mattermost, see documentation)
```bash
0 * * * * root /bin/bash /opt/Carme/Carme-Scripts/maintenance/carme-check-home.sh
```


#### What you should have
In order to proceed we assume that the following software is already installed:

* an empty mysql database
* a parallel or distributed file system (e.g. [BeeGFS](https://www.beegfs.io)). Alternatively, a /home and /opt that is mounted on all nodes.


#### Start with the installation
Now, you can continue to install the various components of Carme. The recommended order is:

* LDAP
* SLURM
* Singularity
* Zabbix
* Mattermost

Installation instructions are given in each folder.

## Configure and Start *Came*

### Generate SSL Certs
*Carme* is using SSL certs to autheticate and encrypt communication between the jobs, the frontend and the backend. Scripts to generate these certs an keys are located in ``/opt/Carme/Carme-Backend/SSL/ ``

#### create backend key and cert
```
openssl genrsa  -out backend.key 4096
openssl req -new -x509 -days 3650 -key backend.key -out backend.crt
```
**NOTE**: backend key and cert should be place in ``/opt/Carme/Carme-Backend/SSL/ `` and **only be readable by root**
 
#### create frontend key and cert
```./createUserCert.sh frontend ```
**NOTE**: frontend key and cert should be place in ``/opt/Carme/Carme-Frontend/webfrontend/SSL/ `` and **only be readable by the webserver user (e.g. _www-data_)**

#### create user certs
run 
```
./createAndDeployUserCarts.sh USERNAME
```
for all useres in *Carme* 

### Backend
For testing, start the backend-server on the head-node like this:
```
/usr/bin/python3 /opt/development/backend/Python/carme_backend.py
```
depending on the debug level set in CarmeConfig, the backend server will produce additional log output on all connections.

Running the backend permanently, one should add it to the system init: e.g. ``/etc/systemd/system/carme-backend.service``
```
[Unit]                                                                                                                                                                                               
Description=CarmeBackeind                                                                                                                                                                                          
Wants=network-online.target                                                                                                                                                                                        
After=network-online.target                                                                                                                                                                                        
                                                                                                                                                                                                                   
[Service]                                                                                                                                                                                                          
Type=simple                                                                                                                                                                                                        
ExecStart=/usr/bin/python3 /opt/Carme/Carme-Backend/Python/carme_backend.py                                                                                                                                        
                                                                                                                                                                                                          
Restart=on-failure                                                                                                                                                                                                 
RestartSec=1                                                                                                                                                                                                       
StartLimitAction=non                                                                                                                                                                                               
                                                                                                                                                                                                                   
[Install]                                                                                                                                                                                                          
WantedBy=multi-user.target  
```

### Frontend

#### migrating the data base
After every update of *Carme*, we need to migrate the SQL datases: in ``/opt/Carme/Carme-Frontend/webfrontend`` do:
```
python manage.py makemigrations
python manage.py migrate
```
This should run through without error messages, populating the MySQL DB.

### migrating static files
```
python manage.py collectstatic
```

### setting up Apache2
Add an new file to ``/etc/apache2/sites-available/``
```
<VirtualHost *:PORT>                                                                                                                                                                                               
 ServerName EXTERNAL_URL                                                                                                                                                                         
 DocumentRoot /opt/Carme/Carme-Frontend/webfrontend/                                                                                                                                                               
 WSGIScriptAlias / /opt/Carme/Carme-Frontend/webfrontend/webfrontend/wsgi.py                                                                                                                                       
                                                                                                                                                                                                                   
 # adjust the following line to match your Python path                                                                                                                                                             
 WSGIDaemonProcess EXTERNAL_URL processes=2 threads=15 display-name=%{GROUP}                                                                                                                     
 WSGIProcessGroup EXTERNAL_URL     
 WSGIApplicationGroup %{GLOBAL}
                                                                                                                                                                                                                   
 <directory /opt/Carme/Carme-Frontend/webfrontend/>                                                                                                                                                                
   AllowOverride all                                                                                                                                                                                               
   Require all granted                                                                                                                                                                                             
   Options FollowSymlinks                                                                                                                                                                                          
 </directory>                                                                                                                                                                                                      
                                                                                                                                                                                                                   
 Alias /static/ /opt/Carme/Carme-Frontend/static/                                                                                                                                                                  
                                                                                                                                                                                                                   
 <Directory /opt/Carme/Carme-Frontend/static/>                                                                                                                                                                     
  Require all granted                                                                                                                                                                                              
 </Directory>                                                                                                                                                                                                      
</VirtualHost>                        
```

### Last Steps
Carme should be working now. The next steps to start working on the cluster are:

* Add admin and users to LDAP (scripts for that can be found in _/opt/Carme/Carme-Scripts/ldap_) and to SLURM (scripts for that can be found in _/opt/Carme/Carme-Scripts/slurm_).
* Login via the web-frontend by opening the web-adress in your browser specified in the proxy and web-frontend installation.
* Start a new job and open JupyterLab.
