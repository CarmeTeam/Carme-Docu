# CarmeConfig
*Carme* has a central configuration file, located at
```
PATH_TO_CARME/CarmeConfig
```
## SECURITY WARNING
*CarmeConfig* contains very sensitve inforation like passwords. It should
* not be hosted on the login node
* only be readable by root

## NOTES
In order to make changes in *CarmeConfig* effective, one must:
* execute ``./deployCarmeConig.sh``
* restart frontend and/or backend servers if changes are in their domain 

## A sample *CarmeConfig*
- ToDo -
