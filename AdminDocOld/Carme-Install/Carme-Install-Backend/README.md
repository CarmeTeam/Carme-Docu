# Install Carme-Backend

The Carme-Backend is a pure Python3 script located in **/opt/Carme/Carme-Backend/Python**. In order to start it we have to make sure that the following libraries are installed on the **headnode**

* python3-pip (installed via repository or anaconda)
* python3-mysqldb (installed via repository or anaconda)
* rpyc (installed via pip)
* ldap3 (installed via pip)
* mysqlclient (installed via pip)

It is important that the version of **rpyc** installed on the heqadnode and inside the frontend image are the same! If this is not the case Carme will not work!
