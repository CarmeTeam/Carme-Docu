# carme-slurm-clean

This is a must have script for each cluster that uses SLURM. SLURM has the ability to execute scripts before and after a job runs. Note that those scripts have to be executable!

As the name might suggests it "cleans a node" after a job has finished. If the last job of a user has finished on a node, the scripts checks if there are any processes of that user left on that particular node and if that is the case it terminates those jobs and reports this in the logs (with job-id and user-name).

The termination is done in two steps (if needed). First a SIGTERM is send to all the processes that are left. Then it waits 30 seconds and checks if the processes are still there. If the processes survive a SIGTERM they get a SIGKILL and logs this too.

Note that in order to avoid killing system processes it checks only for processes of users with an UID larger than 999.
