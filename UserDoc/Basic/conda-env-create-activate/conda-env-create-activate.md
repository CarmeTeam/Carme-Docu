# How to create and activate a conda environment

## Create a conda environment

1. [Open the terminal](../code-server-terminal/code-server-terminal.md) and type:

     ```
   conda create -n <name> python=3.9 -y
   ```
   Note that here, I specifically want to install Python 3.9. If you prefer to use the latest version, replace `python=3.9` with `python=3`. 

## Activate a conda environment
1. To activate the environment, in the terminal type:
     ```
   conda activate <name> 
   ```

2. If you don't recall the name, type the following to list all your conda environments.
     ```
   conda env list 
   ```

3. To know the Python version that is installed in your environment, type:
     ```
    python --version
    ```