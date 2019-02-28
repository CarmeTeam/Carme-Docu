# Install Singularity
For the singularity installation we recommend using the _singularity_ packages available in the standard Linux repositories. To install _singularity_ on all computen nodes and in addition to that _debootstrap_ on the buildnodes you can simply execute
```console
# bash carme-install-singularity.sh
```
Note that _debootstrap_ has to be installed on the buildnodes, as otherwise you cannot create any singularity images at all.

After the installation is done you will be able to both create and execute singularity images. For more information on singularity you should have a look [here](https://www.sylabs.io/docs/).
