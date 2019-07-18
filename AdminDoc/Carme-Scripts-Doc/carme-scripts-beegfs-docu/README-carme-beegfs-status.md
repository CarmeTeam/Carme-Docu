# carme-beegfs-status

**BeeGFS** provides a lot of tools to check the exact status of all daemons and the connection to and between the storage nodes or the meta servers. We do not want to redefine or re-implement all these tools, but in addition to the [start-](README-carme-beegfs-start.md) and [stop-scripts](README-carme-beegfs-stop.md) we have the status-script that simply checks via systemd if the daemons are available.

```console
# bash carme-beegfs-status.sh
```
