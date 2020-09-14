# Install NOTES
* **DISCLAIMER**: The *Carme* install process is still under development. We are working hard on an integrated install process for heterogenious HPC setups and different Linux systems. As of now, the *Carme* installation described here is only valid for ***DEBIAN*** based Linux systems. For other Linux systems please contact us.

* **NOTE**: Feel free to open issues if the current documentation is not complete or something is not clear. If you prefer you can also contact us.

### System requirements
In order to install *Carme*, you should have the following basic setup

#### Hardware
* **Login Node** - simple CPU machine that is connected to where ever your users are comming from. This will run the web-frontend.
* **Head Node** - simple CPU machine, connected to the internals of your HPC system (FS, Batch System)
* Several **Compute Nodes** - powerfull (multi)-GPU machines
* Fast interconnects between head and compute nodes

#### Software
* Parallel File System connecting workers and head-node (e.g. [BeeGFS](https://www.beegfs.io/content/))
* an **MySQL**-Server that is reachable from login and head (support for other databases will come in future releases)
* [**Singularity**](https://sylabs.io/singularity)
* [**newpid**](https://github.com/df7cb/newpid)
* **Python3** environment on the headnode (we recomend to use [anaconda](https://www.anaconda.com/distribution/))


### Using existing HPC Setups
If you are already running an HPC system with a parallel FS and ***Slurm***, you can simply add *Carme* on top of this setup. We recommend to create new *Slurm* partitions for *Carme*.


### Things *Carme* can't do (yet)
* *Carme* currently only supports the ***SLURM*** scheduler.
* Running *Carme* in **non Debian** Linux is possible, but not tested very well. Most install scripts provided here will not start. For more details on installing Carme on **non Debian** Linux Systems please contact us.


## Install Components needed by Carme
In order to run and use Carme you have to install and configure some components. In each of the folder you find either scripts that do most of the basic installations for you and READMEs that provide instructions and/or additional information.

Before you continue make sure that the entire **Carme** repository is located in **/opt** of your headnode 

```console
# git clone https://github.com/CarmeTeam/Carme.git
```

Besides this, make sure that the following folders are mounted
* on the **compute nodes**
  * Carme/Carme-Scripts/InsideContainer
  * Carme/Carme-Scripts/slurm/slurm-epilog-scripts
  * Carme/Carme-Scripts/slurm/slurm-prolog-scripts
  * Carme/Carme-Scripts/frontend
* on the **login node**
  * Carme/Carme-Frontend
  * Carme/Carme-Proxy


### First Step (basic setup)
Before you run any of the scripts, make sure that you edited **CarmeConfig** (see [CarmeConfig Docs](../CarmeConfig.md) according to your needs. This is essential as each script **here** (**and later in productive mode**) depends on **CarmeConfig**.

In order to create **CarmeConfig** you can copy the CarmeConfig_blanco to a new CarmeConfig
```console
# cp /opt/Carme/CarmeConfig_blanco /opt/Carme/CarmeConfig
```
Then you edit CarmeConfig using e.g. vim (or nano)
```console
# vim /opt/Carme/CarmeConfig
```
Note that inside the file are examples (and or default) values for each variable that is defined in CarmeConfig.

After everything is configured you should make the file only accessible to root
```console
# chmod 600 /opt/Carme/CarmeConfig
```

### Second Step (basic installations)
The next steps depend on your needs. If you start from scratch you find here scripts an additional information to install

* [LDAP](Carme-Install-LDAP) (user authentication)
* [SLURM](Carme-Install-Slurm) (scheduler)
* [Singularity](Carme-Install-Singularity) (container solution)
* [Zabbix](Carme-Install-Zabbix) (monitoring)
* [Mattermost](Carme-Install-Mattermost) (self-hosted chat program)

For LDAP, SLURM and Singularity we provide scripts that do the basic installation and configuration for you, so that get a good starting point. For Zabbix and Mattermost we recommend to follow their installation and configuration instructions (links can be found in the respective folders).

In addition you should at this point install the relevant parts for

* [Carme Web-Frontend](Carme-Install-Frontend)
* [Proxy](Carme-Install-Proxy)
* [Carme-Backend](Carme-Install-Backend)


### Third Step (basic initialization)

#### Cronjobs
There are a few scripts that should be added to your **crontab**. For more information have a look at the respective documentaion.

##### headnode
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

##### compute nodes
* carme-find-ghost-jobs-notify.sh (see documentation)
```bash
*/5 * * * * root /bin/bash /opt/Carme/Carme-Scripts/maintenance/carme-find-ghost-jobs-notify.sh
```
* carme-check-home.sh (needs mattermost, see documentation)
```bash
0 * * * * root /bin/bash /opt/Carme/Carme-Scripts/maintenance/carme-check-home.sh
```


#### What you should have so far
In order to proceed we assume that the following things are available

* a running SLURM
* Singularity installed on all nodes
* a user authentication (e.g. LDAP) and existing users
* newpid
* an empty mysql database
* the Singularity images for frontend and proxy are created
* a parallel or distributed file system (e.g. [BeeGFS](https://www.beegfs.io)).  
  Alternatively, a /home or /scratch and /opt that is reachable from all nodes.

optional (if not needed skip in the following steps that include one of these)
* Zabbix (if not installed one would have to modify parts that provide user information like GPU usage)
* Mattermost


#### Configure and Start *Came*

##### Generate SSL Certs
*Carme* is using SSL certs to authenticate and encrypt communication between the jobs, the frontend and the backend. Scripts to generate these certs an keys are located in ``/opt/Carme/Carme-Backend/SSL/ ``. To create backend key and cert execute the following

```console
# cd /opt/Carme/Carme-Backend/SSL/
# openssl genrsa  -out backend.key 4096
# openssl req -new -x509 -days 3650 -key backend.key -out backend.crt
# chmod 600 backend.key
# chmod 600 backend.crt
```
**NOTE**: backend key and cert have to be in ``/opt/Carme/Carme-Backend/SSL/ `` and are **only readable by root**
 
##### create frontend key and cert
Next we have to create a key and cert for the frontend. Note that you have to adjust the following commands according to the values you have defined in the CarmeConfig!

```console
# cd /opt/Carme/Carme-Backend/SSL/
# openssl genrsa -out frontend.key 4096
# openssl req -new -key frontend.key -out frontend.csr -subj "/C=CARME_SSL_C/ST=CARME_SSL_ST/L=CARME_SSL_L/O=CARME_SSL_O/OU=CARME_SSL_OU/CN=CLUSTER_USER/emailAddress=frontend@CARME_SSL_EMAIL_BASE" -passin pass:""
# openssl x509 -req -days 3652 -in frontend.csr -CA backend.crt -CAkey backend.key -set_serial 01 -out frontend.crt
# rm frontend.csr
# chown www-data:www-data frontend.key
# chown www-data:www-data frontend.crt
# mkdir -p /opt/Carme/Carme-Frontend/Carme-Django/webfrontend/SSL
# mv frontend.key /opt/Carme/Carme-Frontend/Carme-Django/webfrontend/SSL/frontend.key
# mv frontend.crt /opt/Carme/Carme-Frontend/Carme-Django/webfrontend/SSL/frontend.crt
```

##### create slurmctld key and cert
Next we have to create a key and cert for the callbacks of the slurmctld. Note that you have to adjust the following commands according to the values you have defined in the CarmeConfig!

```console
# cd /opt/Carme/Carme-Backend/SSL/
# openssl genrsa -out slurmctld.key 4096
# openssl req -new -key slurmctld.key -out slurmctld.csr -subj "/C=CARME_SSL_C/ST=CARME_SSL_ST/L=CARME_SSL_L/O=CARME_SSL_O/OU=CARME_SSL_OU/CN=CLUSTER_USER/emailAddress=slurmctld@CARME_SSL_EMAIL_BASE" -passin pass:""
# openssl x509 -req -days 3652 -in slurmctld.csr -CA backend.crt -CAkey backend.key -set_serial 01 -out slurmctld.crt
# rm slurmctld.csr
# chown slurm:slurm slurmctld.key
# chown slurm:slurm slurmctld.crt
# chmod 600 slurmctld.key
# chmod 600 slurmctld.crt
# mv slurmctld.key /opt/Carme/Carme-Scripts/backend/slurmctld.key
# mv slurmctld.crt /opt/Carme/Carme-Scripts/backend/slurmctld.crt
```

##### create user certs
Next we have to create certs for the users as well. Note that this has to be done every time you add a new user to the system!

The creation can be done with the script **createAndDeployUserCarts.sh** located in **/opt/Carme/Carme-Backend/SSL/**.

#### Start the Carme-Backend
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

#### Start Proxy and Webfrontend

Before you continue make sure that the Singularity images of the proxy and webfronend are created (see install instructions) and copied to the login node, e.g. to

* /opt/Carme-Frontend-Container
* /opt/Carme-Proxy-Container

Note that the scripts

* /opt/Carme/Carme-Scripts/infrastucture/run-carme-frontend.sh
* /opt/Carme/Carme-Scripts/infrastucture/run-carme-proxy.sh

have to be copied to the respective locations as well!

Then we can start them (on the login node!) with
```console
# cd /opt/Carme-Proxy-Container
# bash run-carme-proxy.sh start
```
and
```console
# cd /opt/Carme-Frontend-Container
# bash run-carme-frontend.sh start
```
This will start the respective Singularity containers as deamons (called instanced by Singularity).

##### Migrating the data base
The first time we start Carme and then after every update of *Carme*, we need to migrate the SQL datases used by the web-frontend. To do this we have to enter the frontend image and execute the following commands

```console
# singularity shell instance://CarmeFrontend
# cd /opt/Carme/Carme-Frontend/Carme-Django/webfrontend
# python manage.py makemigrations
# python manage.py migrate
# exit
```
This should run through without error messages, populating the MySQL DB.

##### Migrating Static Files

```console
# singularity shell instance://CarmeFrontend
# cd /opt/Carme/Carme-Frontend/Carme-Django/webfrontend
# python manage.py collectstatic
# exit
```

### Last Steps
Carme should be working now. The next steps to start working on the cluster are:

* Add admin and users to LDAP (scripts for that can be found in _/opt/Carme/Carme-Scripts/ldap_) and to SLURM (scripts for that can be found in _/opt/Carme/Carme-Scripts/slurm_).
* Login via the web-frontend by opening the web-adress in your browser specified in the proxy and web-frontend installation.
* Start a new job and open JupyterLab.
