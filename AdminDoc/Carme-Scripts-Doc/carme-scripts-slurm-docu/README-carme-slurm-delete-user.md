# carme-slurm-delete-user

Script to delete a user (or multiple users) from the SLURM database. The only thing that the script needs is the user-name. The group-id of the user is detected automatically and the respective SLURM account is set with the help of the group-id and the values defined in the _CarmeConfig_.

With this the script executes the delete command
```console
sacctmgr delete user name=USERNAME cluster=CLUSTERNAME account=ACCOUNTNAME
```
for the desired user(s).
