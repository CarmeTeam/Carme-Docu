![logo](figures/carme-logo.png)
# Carme Development Documentation
All development documentation is written in [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).

## Other Documents
* [LICENSES.md](LICENCES.md) contains a list off all libraries and tools used by *Carme*
* [LICENSE.md](LICENCE.md) *Carme* licence

## NOTE: Things to know about the *Carme* License
The [Carme License](LICENCE.md) 

## Languages
*Carme* is developed in the following languages:
* Python 3 (!)
* Bash
* HTML
* Java Script

## Coding Styles
The *Carme* development team uses the following coding styles / standards. 
 
### Python
**[PEP8](http://pypi.python.org/pypi/autopep8/)** - use PEP8 plugins for your favorite editor or the autopep tool:
* INSTALL ``pip3 install autopep8``
* ``autopep8 your_script.py``  dry-run, only print
* ``autopep8 -i your_script.py`` replace content

### Bash
No style defined yet -> ToDo

### HTML + CSS
* Just using standard editor autoindent
* in vim: ``g=G``

### Java Script
No style defined yet -> ToDo

## Bug reports
How to report a bug...

## Merge requests
How to issue a merge request...

* Core developers must agree on request

## API Documentation

### Python
We use [PEP257](https://www.python.org/dev/peps/pep-0257/) conform [docstrings](https://www.pythonforbeginners.com/basics/python-docstrings) to annotate Python code.

#### Automatic API documentation
[Pydoc-Markdown](https://github.com/NiklasRosenstein/pydoc-markdown) is used to generate API ducumentation.

* Install
``
pip3 install pydoc-markdown
``
* Usage
``
pydocmd simple MODULE_NAME++ > OUT.md
``

### Carme Python API
Allowing interarction with *Carme* from python.

### Python Plugins
Extending *Carme* with plugins.

## File Headers
All files in Carme should contain on of the following headers:

### Python / Bash
```
# ---------------------------------------------- 
# Carme
# ----------------------------------------------
# FILENAME - SHORT DESCRIPTION                                                                                                                                                                     
#                                                                                                                                                                                                            
# see Carme development guide for documentation: 
# * Carme/Carme-Doc/DevelDoc/CarmeDevelopmentDocu.md
# * PATHS TO FILE SPECIFIC DOCU                                                                                                                                                                        
#
# Copyright 2019 by Fraunhofer ITWM  
# License: http://open-carme.org/LICENSE.md 
# Contact: info@open-carme.org
# ---------------------------------------------   
```

### HTML
```
<!---
# ---------------------------------------------- 
# Carme
# ----------------------------------------------
# FILENAME - SHORT DESCRIPTION                                                                                                                                                                     
#                                                                                                                                                                                                            
# see Carme development guide for documentation: 
# * Carme/Carme-Doc/DevelDoc/CarmeDevelopmentDocu.md
# * PATHS TO FILE SPECIFIC DOCU                                                                                                                                                                        
#
# Copyright 2019 by Fraunhofer ITWM  
# License: http://open-carme.org/LICENSE.md 
# Contact: info@open-carme.org
# ---------------------------------------------
-->
```

## *Carme* Structure
* add figures
* explain frotend / backend

### Frontend
*Carme-Frontend* is a [Django](https://www.djangoproject.com/) based web-service. Core services include:
* Web GUI
* Authentication and session management
* User rights management
* Image management
* Job-Database
* ...

See [Fronend Documentation](FrontendDocu.md) for details.

### Backend
*Carme-Backend* is a standalone server running with superuser rights. Core services include:
* interarction with the scheduler (starting and stoping jobs)
* passing messages to Mattermost
* user and rights management
* logging
* ....

See [Backend Documentation](BackendDocu.md) for details.


### Proxy

### Typical Setup
Login and Headnode config...


## Central Config File
*Carme* has a single config file: ``CarmeConfig``. It is expected to be located at the carme root directory. See Admin documention for details.

### Reading *CarmeConfig* from Python
```
import imp  
imp.load_source('CarmeConfig', '../../CarmeConfig')  #second arg is relative path to carme root dir 
from CarmeConfig import *            
```
all variables will be available directly. **NOTE:** The Django based *Carme* Frontend is importing *CarmeConfig* into the Django settings domain. See [Fronend Documentation](FrontendDocu.md) for details.

### Reading *CarmeConfig* from Bash
```
source ../../CarmeConfig #use relative path to carme root dir
```
