# Using TensorBoard in Carme

Using TensorBoard in Carme is bit different to procedure you already know. Inside the users HOME-folder exists a folder named _tensorboard_. Per default a job starts with an empty tensorboard folder in _HOME/tensorboard/tensorboad\_JOBID_ and only this folder is visualized in the running job. Note that these folders are temporary folders that is to say they are deleted at the end of the job! So you should _not_ store your results in _HOME/tensorboard_ or _HOME/tensorboard/tensorboard\_JOB-ID_.

## TensorBoard Workflow in Carme

**(1)** Store your simulation results in a separate folder in your HOME (not HOME/tensorboard).

**(2)** In order to visualize your results in TensorBoard open a terminal and use the command **carme\_tensorboard\_visualize**, e.g.
```console
$ carme_tensorboard_visualize results/my-results-1
```
This command creates a symbolic link of _results/my-results-1_ in _tensorboad\_JOB-IB_. With this you have access to _my-results-1_ in TensorBoard inside the the job you are. Note that if you have more than one job running the visualization is one done for the job you executed the command.  
It is forbidden to link your entire HOME-folder!

**(3)** If you do not need results anymore in TensorBoard use **carme\_tensorboard\_unvisualize**
```console
$ carme_tensorboard_unvisualize tensorboard/tensorboard_JOBID/my-results
```
To see which folders are linked at the moment use
```console
$ carme_tensorboard_ls
```

**Note**: Each of the above specified functions has a "help" included. You can access it with
```console
$ carme_tensorboard_visualize --help
$ carme_tensorboard_unvisualize --help
$ carme_tensorboard_ls --help
```
