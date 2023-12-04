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

1. [Open a Jupyter notebook file](../code-server-file-open/code-server-file-open.md) and click on the `kernel button`. Refer to Fig. 1, top-right. In this example, the kernel button reads `base (Python 3.10.6)`. It may also say `Select kernel`.
 
    ![code-server-jupyter-kernel-1.png](images/code-server-jupyter-kernel-1.png)
  
    Fig. 1.

2. A box opens listing all your kernels. To be precise, the list shows all your conda environments, but the kernel is also installed in it. Choose the one that you want to work with. In Fig. 2, for example, we choose `pytorch-mnist`. 

    ![code-server-jupyter-kernel-2.png](images/code-server-jupyter-kernel-2.png)
  
    Fig. 2.
  

3. As shown in Fig. 3, top-right, the kernel button now shows the selected conda environment. With this, you are ready to work with it.

    ![code-server-jupyter-kernel-3.png](images/code-server-jupyter-kernel-3.png)
  
    Fig. 3.



