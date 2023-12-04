# How to test a singularity image with --sandbox


## In Hadez (acheron)

1. `cd /opt/Carme/Carme-ContainerImages/Carme-Frontend-Container`
2. Build a sandbox:
   - `singularity build --sandbox frontend/ frontend.recipe`
3. Access the singularity container sandbox and modify your code:

   - `singularity shell --writable frontend`

4. Once you modify your code, exit the container (`Ctrl+D`) and build the image from the sandbox:

   - `singularity build /tmp/frontend.sif frontend`

5. `mv frontend.sif frontend.sif.bak && mv /tmp/frontend.sif .` 

5. `systemctl restart carme-frontend`

6. Verify your changes. If further testing is needed, repeat from step 3. No need to create the sandbox again

7. Once you are done, copy your modifications to your host, .e.g., if `views.py` was modified, then:   
   - `cp frontend/opt/Carme/Carme-Frontend/Carme-Django/webfrontend/carme/views.py /opt/Carme/Carme-Frontend/Carme-Django/webfrontend/carme/views.py`

8. Remove the sandbox, e.g., `rm -r frontend`.


## In Carme v1.0 (future release)

In the next release, singularity is saved in /opt/Carme/Carme-Vendors. Below we don't create a backup file for easiness:

1. `cd /opt/Carme/Carme-ContainerImages/Carme-Frontend-Container`
2. `/opt/Carme/Carme-Vendors/singularity/bin/singularity build --sandbox frontend/ frontend.recipe`
3. `/opt/Carme/Carme-Vendors/singularity/bin/singularity shell --writable frontend`
4. `/opt/Carme/Carme-Vendors/singularity/bin/singularity build frontend.sif frontend`
5. `systemctl restart carme-frontend`


