# carme

## getHomePath
```python
getHomePath()
```
get the user home directory


## getUserName
```python
getUserName()
```
get the user name inside the container


## getSessionID
```python
getSessionID()
```
get secret session id


## getHomeURL
```python
getHomeURL()
```
get web link to Jupter Lab Entry point of this jom


## getTensorBordURL
```python
getTensorBordURL()
```
get web link to TensorBoard Entry Point of this job


## WhoAmI
```python
WhoAmI()
```
get user authenticaton from Carme backend


## sendNotification
```python
sendNotification(text)
```
send a Mattermost message

#Attributes
    text: message text

#Comment
    can be used to post job status and other information

## addCarmePythonPath
```python
addCarmePythonPath(path, message=True)
```
add a local path to ancaonda search path

#Attributes
    path: path to module
    message: bool

#Comment
    allows import of own modules anywhere in Carme

## resetKernel
```python
resetKernel()
```
resets the kernel of a juyter notebook


