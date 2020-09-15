# Logging

So far we provide different types of logging within CARME - for the proxy, the webfrontend and slurm (different levels). Depending
on what logging we talk about we have to prepare some folders and additional files on the different nodes.


## Proxy and Webfrontend

The login node is here the node that runs the proxy and the webfrontend. Note that if you run proxy and webfrontend on different
nodes you have to do the steps on the respective nodes.

Both services create log files and therefore we have to take care of rotating those logs. To do so we have to create the following
file `/etc/logrotate.d/carme`

```
/var/log/Carme/Carme-Apache-Logs/*.log {
  daily
  rotate 7
  missingok
  compress
  compresscmd /usr/bin/xz
  uncompresscmd /usr/bin/unxz
  compressext .xz
  compressoptions -9
  delaycompress
  notifempty
}

/var/log/Carme/Carme-Traefik-Logs/*.log {
  daily
  rotate 7
  missingok
  maxsize 100M
  compress
  compresscmd /usr/bin/xz
  uncompresscmd /usr/bin/unxz
  compressext .xz
  compressoptions -9
  delaycompress
  notifempty
}
```

This tells the `logrotate` process to rotate the generated files under some special conditions e.g. rotating latest every `7` days
and in the case of the proxy every time the file gets larger than `100MB`.


## SLURM

In the case of SLURM we have different levels of logging - `slurmctld`, `slurmd` and `job output`.

The `job output` - both regular output and errors that appear inside a job - are written to the users home folder in
`${HOME}/.local/share/carme/job-log-dir`.

Regarding the logging for `slurmctld` and `slurmd` we are referring to respective output of the `slurmctld`-prolog and -epilog
scripts and the same for the `slurmd`-prolog and -epilog. This is helpful for debugging as we demand certain steps to be done in
those scripts and if one of these steps fails the job will abort.


### `slurmctld`

(_Note_ that if you have a backup controller carefully duplicate these steps)

The output of the `slurmctld`-prolog and -eplilog is written to `/var/log/carme/slurmctld/prolog` and `/var/log/carme/slurmctld/epilog`
respectively, so make sure that these folders exist!  
Inside these folders every job creates a file `${SLURM_JOB_ID}.log` in order to clean (or archive) those logs we recommend using a
simple `cronjob` as this fits better in that case.

An example of such a `cronjob` would be

```
00 11 * * 6 root find /var/log/carme/slurmctld/prolog -maxdepth 1 -type f -mtime +7 -delete
00 11 * * 6 root find /var/log/carme/slurmctld/prolog -maxdepth 1 -type f -mtime +7 -delete
```

This deletes all files older than `7` days every Saturday at 11.00 a.m., note that you can modify this according to your needs.


### `slurmd`

As we do the logging of the `slurmctld`-prolog and -eplilog scripts we do for the `slurmd`-prolog and -eplilog. Those files are
written to `/var/log/carme/slurmd/prolog` and `/var/log/carme/slurmd/epilog` (make sure those folders exist on each compute node).

Like before we recommend a `cronjob`. So an example would be

```
30 11 * * 6 root find /var/log/carme/slurmd/prolog -maxdepth 1 -type f -mtime +7 -delete
30 11 * * 6 root find /var/log/carme/slurmd/prolog -maxdepth 1 -type f -mtime +7 -delete
```
