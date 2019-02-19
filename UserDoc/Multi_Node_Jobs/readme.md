
# *Carme* Multi-Node Jobs

Currently we support the [Horovod](HowTo_Horovod.md) framework over [MPI](HowTo_MPI.md) for multi node Deep Learning with Tensorflow and Pytorch.

Userers can also 
* use [DASK](HowTo_DASK.md) to write distributed python applications
* write plain [MPI](HowTo_MPI.md) applications
* and [SSH](HowTo_SSH.md) between nodes of a job
* GPI is comming soon
* GPI-Space is comming soon

### How to get the nodes of a running job
``echo $CARME_NODES``

see also *Carme* [ENVs](../HowTo_Variables_and_Bashrc.md)
