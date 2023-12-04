# How to rebuild the Frontend

**Note:** If you are developing the code, rebuilding the image may be time consuming. Therefore, it is better to consider a sandbox, refer to: [How to test a singularity image with --sandbox](../sandbox/sandbox.md).

Access hadez or hades via ssh

## Short version

As an example let's consider hades (styx):

- `carme-manager --build-frontend-image` (builds frontend image and stores a backup file)
- `ssh persephone`
- `systemctl restart carme-frontend-styx.service`

## Long version

### In Hadez (acheron)

1. `cd /opt/Carme`

2. `time singularity build frontend.simg Carme-ContainerImages/Carme-Frontend-Container/frontend.recipe`

3. `mv Carme-ContainerImages/Carme-Frontend-Container/frontend.simg Carme-ContainerImages/Carme-Frontend-Container/frontend.simg.bak`

4. `mv frontend.simg Carme-ContainerImages/Carme-Frontend-Container/frontend.simg`

5. `ssh persephone` (access the login node)

6. `systemctl restart carme-frontend-acheron.service` (restart Carme-Frontend)

7. Clear your browser cache if needed  

### In Hades (styx)

8. Follow steps 1 to 5. Then,

9. `systemctl restart carme-frontend-styx.service`

10. Clear your browser cache if needed
