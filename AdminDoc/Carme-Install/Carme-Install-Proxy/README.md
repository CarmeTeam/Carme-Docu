# Carme-Webfrontend Container

## Create the Proxy Container

In order to create the singularity container containing the webfrontend you need

* to have singularity installed 
* the corresponding recipe file _"recipe--carme-proxy--debian.recipe"_


1. create a singularity image using the recipe-file
```console
# singularity build carme-proxy.simg recipe--carme-proxy--debian.recipe
```

2. copy the singularity image to you _login node_ e.g.
```console
# scp carme-proxy.simg login-node:/opt/Carme-Proxy-Container
```


## Adjust the Config Files


In order to start and run the proxy (traefik) you have to make sure that **/opt/Carme/Carme-Proxy** is mounted from your headnode on the login node!

To start the proxy we have to adjust the needed config files in **/opt/Carme/arme-Proxy/traefik-conf**

```console
# cd /opt/Carme/arme-Proxy/traefik-conf
# cp traefik.blanco traefik.toml && chmod 600 traefik.toml
# cp static.blanco static.toml && chmod 600 static.toml
```

and modify them according to your needs.

Make sure that the certificates for the web sides stored in **/opt/Carme/Carme-Proxy/SSL**!

The last thing to do is to change the file rights

```console
# chown -R www-data:www-data /opt/Carme/Carme-Proxy/traefik-conf
# chown -R www-data:www-data /opt/Carme/Carme-Proxy/SSL
```
