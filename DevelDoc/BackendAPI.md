# carme_backend

## setCarmeLog
```python
setCarmeLog(message, level)
```
adds a message to Carme log files.

__Arguments__

- __message__: string message to be logged
- __level__: int log level (20=info, 30=warning, 10=debug, 40=error)


## sendMatterMostMessage
```python
sendMatterMostMessage(user, message)
```
sends Mattermost message to user

__Arguments__

- __user__: recipiant
- __message__: string

## CarmeBackEndService
```python
CarmeBackEndService(self)
```
Carme backend server class

__Note__

    only methods that are _exposed_ are callable via rpc

### on_connect
```python
CarmeBackEndService.on_connect(self, conn)
```
method is automatically run at new rpc connections

### on_disconnect
```python
CarmeBackEndService.on_disconnect(self, conn)
```
method is automatically run when rpc connection is terminated

### exposed_ping
```python
CarmeBackEndService.exposed_ping(self)
```
simple ping for rpc connection testing

### exposed_whoami
```python
CarmeBackEndService.exposed_whoami(self)
```
simple authentication check

Note: auth will actually fail at on_connect()

### exposed_StartJob
```python
CarmeBackEndService.exposed_StartJob(self, jobUser, jobID, jobImage, jobMounts, jobPartition, jobNumGPUs, jobNumNodes, jobName)
```

Tells the batch-system to schedule a new job

__NOTE__

    only requests from the frontend are exepted

__Arguments__

- __jobUser__: username
- __jobID__: frontend job id
- __jobImage__: image to start
- __jobMounts__: mount points to be set
- __jobPartition__: partition to be used
- __jobNumGPUs__: number of GPUs to be used
- __jobNumNodes__: number of nodes
- __jobName__: name string (NOTE: must be unique)

### exposed_StopJob
```python
CarmeBackEndService.exposed_StopJob(self, jobName, jobUser)
```

Tells the batch system to terminate a job

__NOTE__

    only requests from the frontend are exepted

__Arguments__

- __jobName__: name string of the job
- __jobUser__: username of job owner

### exposed_SetTrigger
```python
CarmeBackEndService.exposed_SetTrigger(self, jobSlurmID, jobUser, jobName)
```

sets batch system trigger for running job

__NOTE__

    only requests from the frontend are exepted

__Arguments__

- __jobSlurmID__: batch system job id
- __jobUser__: username
- __jobName__: name string of the job

### exposed_SendMessage
```python
CarmeBackEndService.exposed_SendMessage(self, user, message)
```

sends Mattermoste message

__Arguments__

- __user__: recipiant user name
- __message__: string

### exposed_SetPassword
```python
CarmeBackEndService.exposed_SetPassword(self, user, user_name, password)
```

sets LDAP user password

__NOTE__

    only requests from the frontend are exepted

__Arguments__

- __user__: LDAP user ID
- __user_name__: user name string
- __password__: new password to be set


