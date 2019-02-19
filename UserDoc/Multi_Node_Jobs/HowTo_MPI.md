
# Running MPI programs within multi-node jobs 

MPI programs can be run interactively within a running *Carme* job.

* Start job with >=2 nodes
* start jupyter terminal
* use the ```carme_mpirun``` alias to start your programm
 * see [mpirun ducumentation](https://www.open-mpi.org/doc/v2.0/man1/mpirun.1.php) for details
* use ``` -n ``` to set the number of workers (max # GPUs per node * # nodes) 

**Notes:**
* multi node jobs allays use all GPUs in node -> see the CARME_GPUS_PER_NODE variable
* MPI is setup to use one rank per GPU
* the maximal number of ranks equals the number of GPUs in the job allocation

## Example

```
user@makariaxx:~$ carme_mpirun -n 2 /home/.CarmeScripts/tests/mpi/pi_test

 Data for JOB [34979,1] offset 0

 ========================   JOB MAP   ========================

 Data for node: makaria07       Num slots: 1    Max slots: 0    Num procs: 1
        Process OMPI jobid: [34979,1] App: 0 Process rank: 0 Bound: UNBOUND

 Data for node: makaria11       Num slots: 1    Max slots: 0    Num procs: 1
        Process OMPI jobid: [34979,1] App: 0 Process rank: 1 Bound: UNBOUND

 =============================================================
np= 2;    Time=1.149036s;    PI=3.1416
```
