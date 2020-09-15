# SLURM "prolog" and "epilog" scripts

Within CARME we make use of both `slurmctld` and `slurmd` "prolog" and "epilog" scripts.

If you already use prolog and epilog scripts within SLURM you have to copy (or symlink) the following files

* `PATH_TO_CARME/Carme-Scripts/slurm/job-scripts/slurmctld-prolog-scripts/prolog.sh`
* `PATH_TO_CARME/Carme-Scripts/slurm/job-scripts/slurmctld-epilog-scripts/epilog.sh`
* `PATH_TO_CARME/Carme-Scripts/slurm/job-scripts/slurmd-prolog-scripts/carme-node-prolog.sh`
* `PATH_TO_CARME/Carme-Scripts/slurm/job-scripts/slurmd-epilog-scripts/carme-slurm-clean.sh`

These scripts are essential for a CARME job and without them a job cannot start. The scripts take care of e.g. the creation of special folders, the registration in the CARME database and other essential steps.

_Note_ that it is totally save to use these scripts in your SLURM setup even if you submit non-carme jobs to your system as each scripts checks first if a job is a carme-job or not and exits if not.
