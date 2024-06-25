# How to customize a conda environment



To perform meaningful calculations, we have to install additional packages in our conda environment. If you don't have a conda environment installed, refer to: [How to create and activate a conda environment](../conda-env-create-activate/conda-env-create-activate.md). Here, we restrict ourselves to a simple example. The code we are going to work with is the following:

```
import torch

# setting device on GPU if available, else CPU
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
print('Using device:', device)
print()

# additional info when using cuda
if device.type == 'cuda':
    print(torch.cuda.get_device_name(0))
```

You can copy the code to a Jupyter notebook or use your own example. Here the file is `mycode.ipynb`.

1. Your Jupyter Notebook file must be in your `home/<username>` directory.

2. In this example, the `Torch` library is required. Compatible versions are listed in https://download.pytorch.org/whl/torch_stable.html.

3. Install `PyTorch`. To do so, [activate the conda environment](../conda-env-create-activate/conda-env-create-activate.md) that you want to work with and then install the package in it:
 
    ```
    conda activate <name>
    conda install pytorch -c pytorch -y
    ```

4. In this example, you may need to install `numpy` also, then

   ```
   pip install numpy
   ```

5. Once the installation is completed you can list all your packages considering
 
    ```
    conda list 
    ```

6. Your environment now has the necessary packages to run `mycode.ipynb`. To run it, refer to: [How to run a Jupyter notebook file](../code-server-run/code-server-run.md).
