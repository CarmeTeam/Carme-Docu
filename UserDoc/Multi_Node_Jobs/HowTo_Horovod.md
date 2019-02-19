
# How to use Horovod with Tensorflow or PyTorch


* Have a look at the [Horovod Documentation](https://github.com/uber/horovod/tree/master/docs) and [examples](https://github.com/uber/horovod/tree/master/examples).
* A working test is available at /home/CarmeScripts/tests/Horovod/
* *Horovod* uses *MPI* to distribute the workload - see [MPI Howto](HowTo_MPI.md)
 * Start job with >=2 nodes
 * start jupyter terminal
 * use the ```carme_mpirun``` alias to start your programm
 
**Notes:**
* multi node jobs allays use all GPUs in node -> see the CARME_GPUS_PER_NODE variable
* MPI is setup to use one rank per GPU
* the maximal number of ranks equals the number of GPUs in the job allocation

## Example
runs distributed MNIST over 2 nodes
```
carme_mpirun -n 2 /opt/anaconda3/bin/python /home/.CarmeScripts/tests/Horovod/horovod_MNIST.py
```
