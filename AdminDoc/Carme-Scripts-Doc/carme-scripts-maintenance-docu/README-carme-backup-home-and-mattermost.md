# carme-backup-home-and-mattermost (optional)

Backups are perhaps one of the most important things one must have. There are really great tools that provide a good backup mechanism - e.g. [rsnapshot](https://rsnapshot.org/) - and we strongly recommend such a tool, but in addition to those you can also use **carme-backup-home-and-mattermost.sh**.

It is so to say "the poor mans version". The script creates a backup - in our case of _/home_ and _mattermost-data_ simply by executing
```bash
time rsync -avhPHAX --stats --delete $PATH_TO_HOME $PATH_TO_HOMEBACKUP
```
and
```bash
time rsync -avhPHAX --stats --delete $PATH_TO_MATTERMOSTDATA $PATH_TO_MATTERMOSTDATABACKUP
```
In contrast to all other scripts, the paths are explicitly written
```bash
PATH_TO_HOME="/mnt/beegfs/home/"
PATH_TO_HOMEBACKUP="/mnt/beegfs/home_backup/"

PATH_TO_MATTERMOSTDATA="/mnt/beegfs/mattermost-data/"
PATH_TO_MATTERMOSTDATABACKUP="/mnt/beegfs/mattermost-data_backup/"
```
and should be seen as one possible example and have to be adjusted according to your needs.
