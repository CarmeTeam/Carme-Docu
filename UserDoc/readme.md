
# *Carme* User Documentation 

## Overview
### What is *Carme* ?

### NOTE
This document is a generic *Carme* ducumentation. All images show the reference system at ITWM - individual *Carme* installations might vary in apperance and functionality. Please also refer to the local documentation.  

### Basic Usage
After logging into a *Carme* system, users will see the following basic home screen 
![home_screen](Images/home_screen.png)
1. **Status bar**: shows user details and session time-out
2. **Log out**
3. **System News**: maintenance and feature announcements 
4. **Cluster utilization**: graph showing the current and past availibility of ressources 
5. **Messages**: *Carme* status messages (e.g. starting/stopping jobs)
6. **Start new job**: select (selection is restricted by user profile)
    * num of nodes 
    * num of GPUs per node
7. **Job image** selection
8. **Job name** (optional)
9. **Start job** button
10. **Running jobs**: list of queued and running jobs
    * NOTE: depending on the availibilit of ressources and user profile quotas, jobs might not start right away 
11. **Entry Points**: list services running in the job image, click to start
12. **Job Infos**: system Information on a running job
    * GPU / CPU / Memory assigned to job
    * GPU usage graph
    * GPU mem usage graph
13. **Stop Job**: manual termination of the job

![tools](Images/carme-tools.png)
Additionally, the home screen shows a ***Carme-Tools*** section with links to:
* This documentation
* The *Carme* group communication tool
* The local Wiki
* User Password management
* User job history
* Image management (restricted to some user groups)

### FAQs
see [our currently updated list of FAQs](FAQ.md)

## How To ...
* [Use the *Jupyter* terminal](HowTo_Terminal.md)
* [Use the *Carme* environment variables](HowTo_Variables_and_Bashrc.md)
* [Use the *Carme* Python API](Carme_Python_API.md)
* [Add new Python Paths](HowTo_Paths.md)

### Multi-Node Jobs
see [Multi Node Doc](Multi_Node_Jobs/readme.md)
