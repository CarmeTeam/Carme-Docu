
# HowTo add Python Paths

Situation: you have your own python modules sitting in ``/home/USER/my_project`` and would like to import these modules in other python scripts.

## Dynamically inside a Python script or notebook
```
import carme 
carme.addCarmePythonPath('/home/USER/my_project')
```
### NOTES:

* this adds your path TEMPORARILY to the anaconda search path (setting is gone in new jobs)
* this is a global opp - only need to do this once per job and will work for all new python calls
* in order to work within a notebook, this resets the running kernel (via jupyter menue or ``carme.restartKernel()``-> should be the first call in a notebook

## Globally at job start
Just add a
```
carme_add_python_path /home/USER/my_project 
```
to your ``/home/USER/.bash_aliases``.

Now, this setting is permanent.
