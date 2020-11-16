# Production websites 

Please refer to wiki for the latest information: https://github.com/k8-proxy/GW-proxy/wiki/Production-websites


## OVAs

Several OVAs to demonstrate Glasswall's rebuild engine.

### ICAP server OVA

- Download OVA file from [here](https://glasswall-sow-ova.s3.amazonaws.com/vms/ICAP-Server/ubuntu.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYVTP3BV6R%2F20201116%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T154927Z&X-Amz-Expires=31536000&X-Amz-SignedHeaders=host&X-Amz-Signature=be6d14893edfa8a63426d0b85de8f8ca5c4d0e9cfa90939f0bf116c654d9dea9)

- Import the OVA to virtualbox and start the VM.

- Login (username: **user**, password: **secret**)

- In command line shell, type:
  
  `ip a show eth1`
​
- check the ip address for eth1 (this address to be used in the following step)

- From the host machine run below command to test the connectivity to ICAP server after updating the IP address from above step.

```
c-icap-client -i 192.168.56.104
```

- Expected results: The command should respond with 200 OK.

### Glasswall Engineering OVA
​
Glasswall Engineering OVA for demoing Glasswall Rebuild engine proxy for **engineering.glasswallsolutions.com** website
​
#### Importing the OVA
​
- Download OVA file from [here](https://glasswall-sow-ova.s3.amazonaws.com/vms/Engineering-website/glasswall-engineering.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYVTP3BV6R%2F20201116%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T155056Z&X-Amz-Expires=31536000&X-Amz-SignedHeaders=host&X-Amz-Signature=f3e4fd8bac2f4b6bb91169496527bcceb7781cf247d4fec4cfc3676d200aa372)
- Open VirtualBox
- Import downloaded OVA file: glasswall-engineering.ova
    
     Expected Result: File is successfully imported
​
- Once OVA is imported, go to the VM **Settings > Network > Adapter 2** 


    Expected Result: 
    ​
    Attached to: Host-Only Adapter

    Name: VirtualBox Host-Only Ethernet Adapter
​
- Start the glasswall-proxy
​
- Login (username: **user**, password: **secret**)
​
- In command line shell, type:
  
  `ip a show eth1`
​

- check the ip address for eth1 (this address to be used in the following step)
​
- If you need to set custom ICAP url, modify **/home/user/k8-reverse-proxy/stable-src/gwproxy.env** as follows
​
- ```bash
  nano /home/user/k8-reverse-proxy/stable-src/gwproxy.env
  ```
  
  Find the line that starts with **ICAP_URL=** , and change the value to the desired ICAP server URL 
​​
- In your hosts file (on Windows: **C:\Windows\System32\drivers\etc**, on MAC/Linux: **/etc/hosts**) add following lines
  
  ```bash
  <IPADDRESS> engineering.glasswallsolutions.com.glasswall-icap.com
  <IPADDRESS> gw-demo-sample-files-eu1.s3-eu-west-1.amazonaws.com.glasswall-icap.com
  ```
​
- Open any browser and try to access: [engineering.glasswallsolutions.com.glasswall-icap.com](https://engineering.glasswallsolutions.com.glasswall-icap.com)
  
  Add needed exceptions to be able to bypass the SSL Certificate warning.


## Setup Minio server using virtualbox and OVA

- Download the OVA from [here](https://glasswall-sow-ova.s3.eu-west-1.amazonaws.com/vms/Minio-Server/minio_server.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYW4UDSC6T%2F20201116%2Feu-west-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T095417Z&X-Amz-Expires=604740&X-Amz-SignedHeaders=host&X-Amz-Signature=15e1d91a6ac7b149ef2d92ef99928f4101c6a5a11e340c1c666bad6362397f88)

- After importing the OVA to virtualbox, make sure network adaptor 1 has "NAT" and adaptor 2 has "VirtualBox Host-Only Ethernet Adaptor"

- Once the VM is started, open the IP address of the VM in browser and it should open minio server.

- Login (username: **user**, password: **secret**)

- Update the /etc/hosts file with the IP address and a DNS name

Example:

    ```
    192.168.56.102 minio.server
    ```

- Once the hosts file is updated, minio can be accessed at http://minio.server from browser.

### Here is the video with above instructions:

[![Minio server OVA](https://img.youtube.com/vi/itMyB8-HTMk/0.jpg)](https://www.youtube.com/watch?v=itMyB8-HTMk)

## Setup proxy for minio server

- Download the OVA from [here](https://glasswall-sow-ova.s3.eu-west-1.amazonaws.com/vms/Minio-Server/minio_proxy.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYW4UDSC6T%2F20201116%2Feu-west-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T095741Z&X-Amz-Expires=604740&X-Amz-SignedHeaders=host&X-Amz-Signature=65c8d8ebe4e79374a5cbb84df7c277b8fb9b848977e67ea6bf4f50e9cc5d41ec)

- After importing the OVA to virtualbox, make sure network adaptor 1 has "NAT" and adaptor 2 has "VirtualBox Host-Only Ethernet Adaptor"

- Once the VM is started, update the /etc/hosts file inside the VM with IP address of above server and DNS name as `minio.server`

Example:

    ```
    192.168.56.102 minio.server
    ```

- In the host machine update the /etc/hosts file with IP address of this server and DNS name as `minio.server.glasswall-icap.com`

Example:

```
192.168.56.102 minio.server
192.168.56.103 minio.server.glasswall-icap.com
```

- Proxied minio server can be now accessed at http://minio.server.glasswall-icap.com

- **Note:** Make sure the IP addresses of above 2 servers are not same. If the IP address is same, run below commands on both VMs to get a new IP address.

```
sudo ip addr flush eth1
sudo dhclient
```

- If you need to set custom ICAP url, modify **/home/user/k8-reverse-proxy/stable-src/gwproxy.env** as follows
​
```bash
nano /home/user/k8-reverse-proxy/stable-src/gwproxy.env
```
  
-  Find the line that starts with **ICAP_URL=** , and change the value to the desired ICAP server URL 
​
