# How to install and choose a Jupyter kernel

## Install the kernel

To run Jupyter notebooks, you need to add a Jupyter kernel in every conda environment that you create. 

1. [ Activate your conda environment ](../conda-env-create-activate/conda-env-create-activate.md) (if it is not).

2. Then, type the following, choosing your own `<name>` (this name can be different from your conda env name): 

    ```
    conda install ipykernel -y && ipython kernel install --user --name "<name>"
    ```
3. You can list your installed Jupyter kernels considering:
     ```
    ls /home/<username>/.local/share/jupyter/kernels
    ```

    or

     ```
    jupyter kernelspec list
    ```
    
4. Refresh your page to update the changes on the screen. 

## Choose the kernel

1. [Open a Jupyter notebook file](../jupyterlab-file-open/jupyterlab-file-open.md) and click on the `kernel button`. Refer to Fig. 1, top-right. In this example, the kernel button reads `Python 3 (ipykernel)`. 
 
    ![jupyterlab-kernel-1.png](images/jupyterlab-kernel-1.png)
  
    Fig. 1.

2. A box opens listing all your kernels. Choose the one that you want to work with. In Fig. 2, for example, we choose `pytorch-mnist`.

    ![jupyterlab-kernel-2.png](images/jupyterlab-kernel-2.png)
  
    Fig. 2.


3. As shown in Fig. 3, top-right, the kernel button now shows `pytorch-mnist`. With this, you are ready to work with it.

    ![jupyterlab-kernel-3.png](images/jupyterlab-kernel-3.png)
  
    Fig. 3.



