
# HowTo: Environment Variables and Bashrc


## .bashrc
**WARNIG** the ***.bashrc*** in user homes is overwritten with a centralized *Carme* default at every job start.

* Use ***.bash_aliases*** in your home to add own additions to *.bashrc*
* System generated *Carme* ENVs are defined in *.bash_carme*

## *Carme* Environment variables
*Carme* defines several ENVs for each job:

| Variable | Content |
|---|---|
|CARME_GPU_LIST| list of GPUs used |
|CARME_GPUS_PER_NODE| # GPUs per node |
|CARME_IMAGE| images used|
|CARME_MEM_PER_NODE| memory per node |
|CARME_NUM_NODES| # nodes |
|CARME_TENSORBOARD_HOME| input path used tensorboard |
|CARME_MASTER| name master node |
|CARME_ACCOUNT_CLASS| user account details |
|CARME_QUEUE| slurm partition used|
|CARME_JOB_NAME| job name |
|CARME_JOBID| jon ID |
|CARME_CPUS_PER_NODE| CPUs per node |
|CARME_NODES| node names |
|CARME_TMP| tmp folder (used by MPI)|

