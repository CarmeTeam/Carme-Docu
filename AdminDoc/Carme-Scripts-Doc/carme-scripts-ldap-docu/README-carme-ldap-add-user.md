# carme-ldap-add-user

Adding a new user to LDAP can - if one is not used to - become quite handy. Using _phpldapadmin_ helps but adding users still requires to look things up in the system.

If we want to add a user we want to

* define the group he should belong to
* set his UID the next free UID
* set a random initial-password
* create the home-directory and copy some files

In order to simplify this procedure you can use **carme-ldap-add-user.sh** via
```console
# bash carme-ldap-add-user.sh
```
Like in all other bash-scripts the scripts guides you. But we want to provide some more details here.

1. checks if _CarmeConfig_ is available, if you are _root_ and if you are on the _headnode_
2. enter the user name of the new user
3. checks if the user-name is uppercase
   (if yes -> exit, if no -> continue)
4. checks if the user already exists.
   (if yes -> exit, if no -> continue)
5. checks if the user-name is empty
   (if yes -> exit, if no -> continue)
6. choose between the LDAP groups that you have defined in _CarmeConfig_
7. gets the highest UID so far and add one to that number
8. you can add an expiration date (note that this will only add an expiration date to the file where the initial-password is stored)
9. enter LDAP admin password (password is not visible on screen)
10. create default random password
11. adds the user to the LDAP database
12. sets the default user password
13. pipes the user-name, uid, password, creation date, expiration date and group-id to a file (_new-ldap-user--DATE--USERNAME.txt_) in _CARME\_LDAP\_DEFAULTPASSWD\_FOLDER_ (defined in _CarmeConfig_)
14. creates the new user home and copies files from _/etc/skel_ and creates _carme\_tmp_ and _.carme_
15. if _CARME\_MATTERMOST\_TRIGGER_ = yes then
    add user to _CARME\_MATTERMOST\_DEFAULT\_TEAM_ with previously created password
16. reminds you to add the user to SLURM (see [README-carme-slurm-add-user](../carme-scripts-slurm-docu/README-carme-slurm-add-user.md))
