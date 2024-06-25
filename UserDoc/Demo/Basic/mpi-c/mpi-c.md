# How to run a python code with mpirun

To test this example start a job with 2 nodes, see Fig. 1

  <img src="images/2-nodes.png" alt="2-nodes.png" width="850"> 
    
  Fig. 1.

**Note:** Carme uses `carme_mpirun` instead of `mpirun`. The former adds additional flags to the mpirun command.


1. As an example, create a cpp file:

   ```
   cd /home/<username> && touch hello_world.cpp
   ```
3. Copy the following code to the file:

   ```
   #include <stdio.h>
   #include <mpi.h>

   int main(int argc, char** argv){
      int process_Rank, size_Of_Cluster;

      MPI_Init(&argc, &argv);
      MPI_Comm_size(MPI_COMM_WORLD, &size_Of_Cluster);
      MPI_Comm_rank(MPI_COMM_WORLD, &process_Rank);

      printf("Hello World from process %d of %d\n", process_Rank, size_Of_Cluster);

      MPI_Finalize();
      return 0;
   }
   ```
3. Compile your file:

   ```
   mpic++ hello_world.cpp -o hello_world.exe
   ```

4. Run your executable file:

    ```
    carme_mpirun -np 2 ./hello_world.cpp
    ```

4. The output shows that two processors were used:

   ```
   Hello, World from process 0 of 2.
   Hello, World from process 1 of 2.
   ```

