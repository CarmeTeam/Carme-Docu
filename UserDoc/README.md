# Carme user documentation

If you have a suggestion or a question that is not resolved in this documentation, please contact the Carme Team: 

[carme@itwm.fraunhofer.de](carme@itwm.fraunhofer.de)

**Note:** 

- If you are a Carme user in an already existing cluster, refer to: 

  [Local user documentation](./Docu/docu-access/docu-access.md).

- If you are testing Carme-demo, refer to: 

  [Carme-demo user documentation](./Demo/README.md).

## Topics

First-time users should follow the steps given in **Access: First Time** and **Usage: First Time**. 

### Access: First Time

* Step 1: [ Log in to Carme and set up the 2FA](./System/login/login.md)
* Step 2: [ Create or join a project](./System/project/project.md)

### Access: Basic options

**Documentation** 
* [How to access the local user documentation](./Docu/docu-access/docu-access.md)

**Two-Factor-Authentication** 
* [How to set up the 2FA using Google Auth](./2FA/2FA-google-auth/2FA-google-auth.md)
* [How to set up the 2FA using KeePassXC](./2FA/2FA-keepass-xc/2FA-keepass-xc.md)
* [How to set up the 2FA using Yubikey](./2FA/2FA-yubikey/2FA-yubikey.md)
* [How to get backup tokens](./2FA/2FA-backup/2FA-backup.md)
* [How to reset the 2FA](./2FA/2FA-reset-user/2FA-reset-user.md)

**Project Management**
* Introduction 
  * [What is a project](./Projects/project-definition/project-definition.md)
* First Steps 
  * [How to create a project](./Projects/project-create/project-create.md)
  * [How to get a project ID](./Projects/project-id/project-id.md) 
  * [How to update a project](./Projects/project-update/project-update.md)
  * [How to delete a project](./Projects/project-delete/project-delete.md)
* Admin options
  * [How to invite users to join a project](./Projects/project-invite/project-invite.md)
  * [How to accept a request to join a project](./Projects/project-accept/project-accept-admin.md)
  * [How to reject a request to join a project](./Projects/project-reject/project-reject-admin.md)
  * [How to cancel an invitation or request to join a project](./Projects/project-cancel/project-cancel-admin.md)
  * [How to remove a user from a project](./Projects/project-remove/project-remove.md)
  * [How to set a user as project admin](./Projects/project-set-admin/project-set-admin.md)
* User options
  * [How to submit a request to join a project](./Projects/project-request/project-request.md)
  * [How to accept an invitation to join a project](./Projects/project-accept/project-accept-user.md)
  * [How to reject an invitation to join a project](./Projects/project-reject/project-reject-user.md)
  * [How to cancel an invitation or request to join a project](./Projects/project-cancel/project-cancel-user.md)
  * [How to leave a project](./Projects/project-leave/project-leave.md)
  
-----------------------------------------------------------------------------------------------------------------------

### Usage: First Time
The steps given here are focused on running Jupyter notebooks in Code-Server.

* Step 1: [ Start a job ](./Basic/job-start/job-start.md)
* Step 2: [ Set up Code-Server](./Basic/code-server-set-up/code-server-set-up.md)
* Step 3: [ Install Jupyter extensions](./Basic/code-server-jupyter-extension/code-server-jupyter-extension.md)
* Step 4: [ Create and activate a conda environment ](./Basic/conda-env-create-activate/conda-env-create-activate.md)
* Step 5: [ Install and choose a Jupyter kernel](./Basic/code-server-jupyter-kernel/code-server-jupyter-kernel.md)
* Step 6: [ Customize the conda environment](./Basic/conda-env-customize/conda-env-customize.md)
* Step 7: [ Run your code](./Basic/code-server-run/code-server-run.md)


### Usage: Basic Options
* Carme Dashboard 
  * [How to start a job](./Basic/job-start/job-start.md)
  * [How to stop a job](./Basic/job-stop/job-stop.md)
* Code-Server Entry Point
  * [How to access](./Basic/code-server-access/code-server-access.md)
  * [How to open a terminal](./Basic/code-server-terminal/code-server-terminal.md)
  * [How to split the screen](./Basic/code-server-split/code-server-split.md)
  * [How to change the theme color](./Basic/code-server-color/code-server-color.md)
  * [How to open a file](./Basic/code-server-file-open/code-server-file-open.md)
  * [How to create a file](./Basic/code-server-file-create/code-server-file-create.md)
  * [How to navigate to a different directory](./Basic/code-server-directory/code-server-directory.md)
  * [How to install Jupyter extensions](./Basic/code-server-jupyter-extension/code-server-jupyter-extension.md)
  * [How to install Visual Studio Code extensions](./Basic/code-server-vsc-extension/code-server-vsc-extension.md)
  * [How to install and choose a Jupyter kernel](./Basic/code-server-jupyter-kernel/code-server-jupyter-kernel.md)
  * [How to upload/download files](./Basic/code-server-file-transfer/code-server-file-transfer.md)
  * [How to run a Jupyter notebook file](./Basic/code-server-run/code-server-run.md) 
* JupyterLab Entry point 
  * [How to access](./Basic/jupyterlab-access/jupyterlab-access.md)
  * [How to open a terminal](./Basic/jupyterlab-terminal/jupyterlab-terminal.md)
  * [How to split the screen](./Basic/jupyterlab-split/jupyterlab-split.md)
  * [How to open a file](./Basic/jupyterlab-file-open/jupyterlab-file-open.md)
  * [How to create a file](./Basic/jupyterlab-file-create/jupyterlab-file-create.md)
  * [How to navigate to a different directory](./Basic/jupyterlab-directory/jupyterlab-directory.md)
  * [How to install and choose a Jupyter kernel](./Basic/jupyterlab-kernel/jupyterlab-kernel.md)
  * [How to upload/download files](./Basic/jupyterlab-file-transfer/jupyterlab-file-transfer.md)
  * [How to run a Jupyter notebook file](./Basic/jupyterlab-run/jupyterlab-run.md) 
* Environments and Resources
  * [Default software packages installed](./Basic/software-default/software-default.md)
  * [How to install software packages](./Basic/software-install/software-install.md)
  * [How to create and activate a conda environment](./Basic/conda-env-create-activate/conda-env-create-activate.md)
  * [How to deactivate and remove a conda environment](./Basic/conda-env-deactivate-remove/conda-env-deactivate-remove.md)
  * [How to customize a conda environment](./Basic/conda-env-customize/conda-env-customize.md)
* Checkpoints
  * [ How to check the GPU driver version](./Basic/cuda-driver/cuda-driver.md)
  * [ How to monitor the GPU utilization](./Basic/nvtop/nvtop.md)
  * [ How to check the log file of your job](./Basic/log-file/log-file.md)
