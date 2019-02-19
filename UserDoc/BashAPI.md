# *Carme* Bash API
Collection of bash scripts for various tasks. These scripts are available in any terminal within *Carme* jobs.

### carme_canceljob()
Save and clean termination of jobs running inside a container. 

### carme-archive()
```
carme-archive creates a compressed tar-file (tar.gz) of
the specified folder(s)/file(s) (see USAGE) and after the
archive is created deletes the original folder(s)/file(s).

USAGE:
carme-archive ARCHIVE-NAME FOLDER
or
carme-archive ARCHIVE-NAME FOLDER-1 FOLDER-2 ...
or
carme-archive ARCHIVE-NAME FILE-1 FILE-2 FILE3 ...
```

### carme-unarchive()
```
carme-archive creates a compressed tar-file (tar.gz) of
the specified folder(s)/file(s) (see USAGE) and after the
archive is created deletes the original folder(s)/file(s).

USAGE:
carme-archive ARCHIVE-NAME FOLDER
or
carme-archive ARCHIVE-NAME FOLDER-1 FOLDER-2 ...
or
carme-archive ARCHIVE-NAME FILE-1 FILE-2 FILE3 ...
[keuper@makaria16:~]$ carme-unarchive --help
carme-unarchive extracts a compressed tar-file (tar.gz)
in the local folder and then removes the original archive.

USAGE:
carme-unarchive ARCHIVE-NAME.tar.gz
```

### carme_tensorboard_visualize()
```
With carme_tensorboard_visualize you can add previous results to your running tensorboard.
You should only add the results you need (and not your entire home folder)!! Per default a
job starts with an empty tensorboard folder in HOME/tensorboard/tensorboad_JOBID and only
this folder is visualized in the running job. Note that this folder is delated on a regular
base. Therefore you should use this function to temporarily make your results visible in
your running job.

USAGE:
e.g. carme_tensorboard_visualize results/my-results-1

NOTE:
You can delete such a temporarily visible folder with carme_tensorboard_unvisualize.
```

### carme_tensorboard_unvisualize()
```
With carme_tensorboard_unvisualize you can remove results so that they are no longer
visible within tensorboard in your runinng job.

USAGE:
e.g. carme_tensorboard_unvisualize tensorboard/tensorboard_JOBID/my-results
```

### carme_tensorboard_ls()
```
With carme_tensorboard_ls you can see which folders
are linked to your current tensorboard job-folder.

USAGE:
carme_tensorboard_ls
```

