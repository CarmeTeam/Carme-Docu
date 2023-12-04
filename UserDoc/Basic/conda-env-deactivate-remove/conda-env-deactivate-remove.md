# How to deactivate and remove a conda environment

## Deactivate a conda environment

1. If your conda environment is activated. Type the following to deactivate it:

     ```
   conda deactivate <name> 
   ```

## Remove a conda environment
1. Once your conda environment is deactivated, To remove it, type the following:

     ```
   conda remove -n <name> --all -y
   ```

2. If you get a warning message. Ignore it. It will disappear once you start a new job. 


3. You should also remove the kernel installation. In the terminal type:

     ```
   jupyter kernelspec uninstall <name> -y
   ```

4. To remove all unused conda packages. In the terminal type:

     ```
   conda clean --all 
   ```

5. Start a new job to remove possible cache files.

6. Verify if your `home/<username>/.conda/pkgs` directory still has unwanted packages installed. If it does, repeat step 4. 