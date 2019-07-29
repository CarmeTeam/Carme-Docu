# Carme-Webfrontend Container

## Create the Singularity Container

In order to create the singularity container containing the webfrontend you need

* to have singularity installed 
* the corresponding recipe file
  * _"recipe--carme-frontend.recipe"_ (Ubuntu inside the image)
  * _"recipe--carme-frontend--debian.recipe"_ (Debian inside the image)
* If you use the Ubuntu Image you need a Ubuntu 18.04 sources.list saved as _/home/root-back/SOFT/sources-list/sources--18-04.list_. Note that if it is stored at a different location or has a different name edit line 12 in _"recipe--carme-frontend.recipe"_.

At least for some singularity versions you will run into the problem that you cannot install all needed python packages via the recipe-file. Therefore, and until further notice, the creation procedure is as follows (you need to be root)

1. create a sandbox image using the recipe-file
```console
# singularity build --sandbox carme-frontend-sandbox recipe--carme-frontend.recipe
```
or
```console
# singularity build --sandbox carme-frontend-sandbox recipe--carme-frontend--debian.recipe
```

2. enter the sandbox
```console
# singularity shell --writable carme-frontend-sandbox
```
and install the needed python packages
```console
# pip3 install django
# pip3 install django-auth-ldap django-auth-ldap django-bootstrap-themes django-chartjs django-classy-tags django-db-logger django-filter django-js-asset django-logtailer django-maintenance-mode django-material django-material django-mptt django-nyt django-sekizai django-settings-export django-todo django-viewflow django-viewflow mysqlclient numpy rpyc whitenoise wiki
```
Note that you have to make sure that the version of _"rpyc"_ in this image and the one installed on the headnode for the _Carme-Backend_ is the same! Otherwise it will not work.

3. create the compressed singularity image from the sandbox and delete the sandbox
```console
# singularity build carme-frontend.simg carme-frontend-sandbox
# rm -r carme-frontend-sandbox
```

4. copy the singularity image to you _login-node_ e.g.
```console
# scp carme-frontend.simg login-node:/opt/Carme-Frontend-Container
```

## Adjust the Config Files

In order to start and run the web-frontend you have to make sure that **/opt/Carme/Carme-Frontend** is mounted from your headnode on the login node!

To start the web-frontend we have to adjust the needed config files in **/opt/Carme/Carme-Frontend/Carme-Server-Conf**.

The first file we need is a valid **hosts** file. Therefore we can use the provided "blanco" file

```console
# cd /opt/Carme/Carme-Frontend/Carme-Server-Conf
# cp hosts_blanco hosts
```

In this hostfile we have to write the **internal IP address** and **hostname** of the login node.

Next we have to adjust the apache config files in **/opt/Carme/Carme-Frontend/Carme-Server-Conf/apache2**

```console
# cd /opt/Carme/Carme-Frontend/Carme-Server-Conf/apache2
# cp 002-gpu.blanco 002-gpu.conf
# cp apache2.blanco apache2.conf
# cp ports.blanco ports.conf
```

Now have to do the following modifications

1. **002-gpu.conf**
  * line 1: the port of the virtual host
  * line 2: server-name.de (the name you defined in CarmeConfig as CARME_URL)
  * line 7: server-name.de
  * line 8: server-name.de

2. **apache2.conf**
  * line 236: HOSTNAME (login node)

3. **ports.conf**
  * line 5: the port the web-frontend is supposed to run
