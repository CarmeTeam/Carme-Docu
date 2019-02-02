# carme-slurm-modify-user

What jobs or resources users are allowed to do is handled via the SLURM database and is set the moment the user is created in the database. With _sacctmgr modify_ we are able to manipulate the things users are allowed to do afterwards. Essentially we can set and modify nearly everything e.g. the maximum nuber of jobs or the total time a user can run simulations. For a more detailed list of what is possible you should have a look [here](https://slurm.schedmd.com/resource_limits.html) and [here](https://slurm.schedmd.com/sacctmgr.html).
