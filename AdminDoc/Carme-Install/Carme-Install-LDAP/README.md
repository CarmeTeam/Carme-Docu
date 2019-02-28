# Install LDAP

## Install LDAP on the Headnode
In order to generate a LDAP datebase you can use the script **carme-install-ldap.sh** via
```console
# bash carme-install-ldap-headnode.sh
```
You will get a basic LDAP database, without sslv3 encryption.


## Setup User Management System
It is strongly recommended to install **phpldapadmin**, a web-frontend for the LDAP database. For debian based systems you can install it using
```console
# apt update
# apt install -y phpldapadmin
```
You have to configure the webinterface by editing the configuration file located in **/etc/phpldapadmin/config.php**.
```console
# vim /etc/phpldapadmin/config.php
# nano /etc/phpldapadmin/config.php
```
First you should change the timezone in the line containing **$config->custom->appearance['timezone']** accordingly, e.g.
```php
$config->custom->appearance['timezone'] = 'Europe/Berlin';
```
Make sure all arguments are passed in single quotes ' '.  

Next you have to add the servername in the line **$servers->setValue('server','name','...');**, e.g.
```php
$servers->setValue('server','name','My Server');
```
Change the IP address for the LDAP communication, as it was set in the CarmeConfig under $CARME_LDAP_URI ( $servers->setValue('server','host','...') )
```php
$servers->setValue('server','host','CARME_LDAP_URI IP Adress');
```
Optionally, if you want to set a default user for the tool, you can set it with
```php
$servers->setValue('login','bind_id','cn=...,dc=...,dc=...');
```
It is strongly recommended to uncomment the following line in order to avoid anonymous login from the outside
```php
$servers->setValue('login','anon_bind',false);
```
**phpldapadmin** is now configured. You can login to the tool with your browser, using the address [?].


## Install LDAP on the clients
On the clients we have to install the following packages:
```console
# apt -y install libnss-ldapd libpam-ldap ldap-utils nscd
```
You will be prompted to specify the IP address of the headnode and the domain name of the LDAP database (see the CarmeConfig).

LDAP is now ready to be used on the cluster.
