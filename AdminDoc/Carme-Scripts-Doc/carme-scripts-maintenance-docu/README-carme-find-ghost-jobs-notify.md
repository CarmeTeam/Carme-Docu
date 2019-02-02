# carme-find-ghost-jobs-notify

**carme-find-ghost-jobs-notify.sh** is like **carme-slurm-clean.sh** a really important script. To make this a bit clearer we should say a few more words.

On every HPC cluster that exists, a scheduler is used to handle job resources. The advantage is that users have to specify the resources they need and they have access to exactly those resources. If they try to request more there job is killed.
In most cases this works fine, but there are situations in which a user process either manages to continue running aber there jobs is done or they manage to daemonize a process. Both situations are bad because this way it could be possible to use resources that you did not specify in the beginning. Therefore we have **carme-find-ghost-jobs-notify.sh** and **carme-slurm-clean.sh**.

The duty of **carme-find-ghost-jobs-notify.sh** is to find jobs that belong to a normal user but have parent-id PPID=1. This would correspond to jobs that run outside a job that was submitted via the scheduler and are because of that not limited.

At the moment the script **detects**, **informs** (via Mattermost and Systemlog) and **kills** user processes with **PPID=1** and  that have state
* R
* S
* Sl
