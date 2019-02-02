# carme-nodes-exec

**carme-nodes-exec.sh** is a tiny script to execute a command on each node that is defined in **CarmeConfig** in the **CARME_NODES_LIST**-variable.

The idea of the script is as follows

* ssh to a _NODE_ given in _CARME\_NODES\_LIST_
* execute a _COMMAND_
* exit this node
* repeat for all nodes in _CARME\_NODES\_LIST_

Both the advantage and disadvantage of this script is that the _COMMAND_ is executed on one node after the other. It takes longer till this way but we see directly if something goes wrong.

In oder to run the script you simply have to typ
```console
# bash carme-nodes-exec.sh
```
Then the script will ask you if you want to execute a command on all nodes and then asks you to typ the _COMMAND_ you want to execute (note that there is no autocompletion at this point).
