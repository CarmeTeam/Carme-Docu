# *Carme* Backend Server
The backend server is the central control instance of a *Carme* system:
* it is the only module that requires **root** rights 
    * therfore, it should not run on a node that can be directly accesed from the outside
    * it is the only instance that has write access to the *Carme* database
    * all interactions with the backend requires SSL based authentication and encryption  
* it handles all scheduling and messaging tasks
* ...

## Structure
The backend has three main parts:
* the python backend server
* some bash scripts called by the server
* SSL scripts and certs
```
.
├── Bash
│   ├── submitJob.sh
│   └── triggerCall.sh
├── Python
│   └── carme_backend.py
└── SSL
    ├── backend.crt
    ├── backend.key
    ├── createAndDeployUserCarts.sh
    ├── create_keys.txt
    └── createUserCert.sh

```

## Python RPC
The python backend server is using the [RPyC](https://rpyc.readthedocs.io/en/latest/) to implement secure communication.

### SSL authentication
* Use the ``createAndDeployUserCarts.sh`` script to generate signed user certs and keys 

## API
The Backend API can be called by the frontend, other apps and users (see [User API](../UserDoc/PythonAPI.md) )
* see [BackendAPI](BackendAPI.md) for the backend API
