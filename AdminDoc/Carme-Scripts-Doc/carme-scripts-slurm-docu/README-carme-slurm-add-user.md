# carme-slurm-add-user

After a user is added to the LDAP database we have to add it to the SLURM database as well (if the user should have the ability to start jobs on the cluster). You need to separate scripts _carme-ldap-add-user.sh_ AND _carme-slurm-add-user.sh_ as there is some delay (5-10 seconds depends on the OS) between adding a user to LDAP and its availability in the system.

The only thing that is needed ist the user-name. The script detects automatically the group-id of the user and according to the different cases defined in _CarmeConfig_.

Note that you can add multiple users to SLURM with this script, simply when asked writing a space separated list of user-names. After the user is added SLURM will ask you if you want to keep the changes. SLURM gives you 30 seconds for the decision and you should be aware that the default of the question is no.
