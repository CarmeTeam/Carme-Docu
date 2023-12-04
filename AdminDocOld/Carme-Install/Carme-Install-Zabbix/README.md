# Install Zabbix
Zabbix is our (preferred) monitoring tool as it fits great in our setup. In order to install zabbix on the cluster we strongly recommend following the [zabbix documentation](https://www.zabbix.com/manuals). It provides you with all the information you need to install and configure zabbix.

In (most) linux repositories you find nearly all the packages needed for the installation. In order to use zabbix in combination with GPUs you have to install an [additional plugin](https://share.zabbix.com/cat-server-hardware/other/nvidia-smi-monitoring-for-multiple-gpus). In contrast to the installation instructions given there, we suggest to place the script named **get_gpus_info.sh** in a folder that is accessible for all nodes in the cluster. Which results in a simple change
```console
UserParameter=gpu.discovery,/etc/zabbix/scripts/get_gpus_info.sh -> UserParameter=gpu.discovery,/PATH-TO-THE-SCRIPT/get_gpus_info.sh
```
Note that the only reason for this has administrative reasons.

Another handy plugin is to monitor the [disk performance](https://share.zabbix.com/storage-devices/linux-disk-performance-monitoring).

Those are only two examples of useful plugins but there are many more on [zabbix share](https://share.zabbix.com/) and you always have the possibility to write your own plugins.
