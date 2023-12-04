# carme-empty-trash

If we delete a file in _JupyterLab_ it is sent to _/home/user/.local/share/Trash_. The problem (bug) is that JupyterLab has no final delete button which results in an extremely large user thrash.

To solve this problem **carme-empty-trash.sh** deletes all files in _/home/user/.local/share/Trash_. The script can either be executes manually but we recommend to run it as cronjob, e.g. every saturday
```bash
30 19 * * 6 root /bin/bash /opt/Carme/Carme-Scripts/maintenance/carme-empty-trash.sh
```
