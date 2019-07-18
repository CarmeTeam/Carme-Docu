# carme-mattermost-add-user

With this script you can add a user to mattermost that should have ONLY access to mattermost, but not the rest of the cluster. This can be quite useful for external people that should participate in the overall chat but do not have to run simulations on the cluster.

The script uses the following **CarmeConfig** variables
* _CARME\_MATTERMOST\_COMMAND_
* _CARME\_MATTERMOST\_DEFAULT\_TEAM_
* _CARME\_MATTERMOST\_EMAIL\_BASE_
* _CARME\_LDAP\_DEFAULTPASSWD\_FOLDER_ (the default passwords of the new mattermost users are stored in this folder in a text file that looks like _new-mattermost-user--DATE--USER.txt_)
