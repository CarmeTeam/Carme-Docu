# carme-check-home

Having mattermost running and _CARME\_MATTERMOST\_WEBHOCK_ set in _CarmeConfig_, we can use it in addition to monitoring tools like for example [zabbix](https://www.zabbix.com/) or [ganglia](http://ganglia.info/).

One example can be found here. The script checks if _/home_ is mounted (available) and if not send a mattermost message
```console
HOSTNAME : /home is not mounted
```
Therefore the script should be added to _/etc/crontab_
```bash
0 * * * * root /bin/bash /opt/Carme/Carme-Scripts/maintenance/carme-check-home.sh
```
of all nodes that have to mount _/home_.
