
# Carme User FAQ
* [Use the *Jupyter* terminal](HowTo_Terminal.md)
* [Use the *Carme* environment variables](HowTo_Variables_and_Bashrc.md)
* [Use the *Carme* Python API](Carme_Python_API.md)
* [Add new Python Paths](HowTo_Paths.md)
* [What are the job timeouts?](#job-timeouts)
* [How to upload data?](#data-upload)

## Job timeouts 

* the default setting is, that jupyter will stop inactive kernels after **60 minutes**
* carme will stop the job if there are no active within **60 minutes**

Hence, jobs time about after **60 - 120 min** inactivity.

## Data upload 

User data uploads into *Carme* are restricted. But there are several ways to upload your data:

* Use the *Jupyter* web interface (max file size: 15MB)
<br>
<br>
![upload](Images/carme_upload.png)
<br>
<br>
* Use *scp* from a terminal to copy external data (this option is restricted to privileged users)

* For larger data sets we advise to ask your local *Carme* administrator

