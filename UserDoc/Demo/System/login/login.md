# Access Carme-demo

All interactions run through the **Carme-demo** webfrontend.


- In single-devices or in the head-node, open a web browser and type:

  ```
  localhost:10443
  ```

- To remotely access Carme-demo, use SSH tunnel. In your remote device proceed as follows: 
   - Open the terminal and type: 
   
     ```
     ssh <username>@<IP> -NL 9999:localhost:10443
     ```
     
      **Note:** IP refers to the head-node or the single device IP.
   - Then, open the web browser and type: 
   
     ```
     localhost:9999
     ```


