
# Carme User FAQ

[toc]

## What are the job timeouts? 

* the default setting is, that jupyter will stop inactive kernels after **60 minutes**
* carme will stop the job if there are no active within **60 minutes**

Hence, jobs time about after **60 - 120 min** inactivity.

## How to upload data?

User data uploads into *Carme* are restricted. But there are several ways to upload your data:

* Use the *Jupyter* web interface (max file size: 15MB)
<br>
<br>
<img src="Images/carme_upload.png">
<br>
<br>
* Use *scp* from a terminal to copy external data (this option is restricted to privileged users)

* For larger data sets we advise to ask your local *Carme* administrator

