# Carme-Scripts Documentation

The admin shell scripts are located in 
```
PATH_TO_CARME/Carme-Scripts/
```
and are organized by topics in several foldes:

Each folder
 * [beegfs](carme-scripts-beegfs-docu/README.md)
 * [ldap](carme-scripts-ldap-docu/README.md)
 * [maintenance](carme-scripts-maintenance-docu/README.md)
 * [mattermost](carme-scripts-mattermost-docu/README.md)
 * [node-exec](carme-scripts-node-exec-docu/README.md)
 * [slurm](carme-scripts-slurm-docu/README.md)
 * systemd -> ToDo
 * tests -> ToDo

contains a global README and additionally a README for each script.

Note that if not explicitly mentioned in the script READMEs each (bash) script is executed in the same fashion
```console
# bash SCRIPT-NAME.sh
```
There are no additional parameters at this point. If additional parameters are needed the script will ask you to typ after the execution of the script has started.
