# *Carme* Multi-Node and Multi-GPU Jobs

Currently CARME supports different engines that can be used for multi-node repectively multi-GPU jobs. Within in the singularity containers users have - depneding on the rules provided by the system administrator - access to `ssh` and therefore to a large variety of frameworks for distributed multi-node and/or multi-GPU trainings.

Amoung the frameworks that can be used within CARME are

* (plain) [**SSH**](HowTo_SSH.md)
* [**MPI**](HowTo_MPI.md)
* **GPI**
* **GPI-Space**
* [Horovod](HowTo_Horovod.md)
* [DASK](HowTo_DASK.md)


### How to get the nodes of a running job
``echo $CARME_NODES``

see also *Carme* [ENVs](../HowTo_Variables_and_Bashrc.md)
