# *Carme* Entry Points
In *Carme*, so called *Entry Points* define webservices which are running inside a user container. 
By design, an *Entry Point* could be any service that comminicates via ``https`` to the outside. 
* Advanced users and administrators can add new services inside containers and register them within *Carme*
* Hence, different images might provide different Entry Points

## Default Entry Points
By default, the *Carme* base-image provides the following *Entry Points*

* [Shell](#shell)
* [Jupyter Lab](#jupyter-lab) 
* [TensorBoard](#tensorboard)
* [Theia IDE](#theia)
* [DASK Monitor](#dask) (multi-node jobs only)

## Shell

## Jupyter Lab

## Tensor Board

## Thiea

## DASK
