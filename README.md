# Production websites 

Please refer to wiki for the latest information: https://github.com/k8-proxy/GW-proxy/wiki/Production-websites


# OVAs

- Minio Server 
- Minio Proxy 
- Glasswall Engineering Website Proxied
- ICAP Server

## ICAP server OVA

- Download OVA file from [here](https://glasswall-sow-ova.s3.amazonaws.com/vms/ICAP-Server/ubuntu.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYVTP3BV6R%2F20201116%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T154927Z&X-Amz-Expires=31536000&X-Amz-SignedHeaders=host&X-Amz-Signature=be6d14893edfa8a63426d0b85de8f8ca5c4d0e9cfa90939f0bf116c654d9dea9)

- Open VirtualBox and import downloaded OVA file: icap-server.ova

- Once OVA is imported, go to Settings>Network>Adapter 2 
 
  `Name: VirtualBox Host-Only Ethernet Adapter`

  `Attached to: Host-Only Adapter`

- Start ICAP Server VM

- Login (username: **ubuntu**, password: **mikihiir**)

- In command line shell, type:
  
  `ip a show eth1`
​
- Check the ip address for eth1 (this address to be used in the following step)

- On your localhost machine (make sure you have c-icap-client installed) run below command to test the connectivity to ICAP server:

  `c-icap-client -i 192.168.56.104`

- Expected results: The command should respond with 200 OK.

## Glasswall Engineering OVA
​
Glasswall Engineering OVA for demoing Glasswall Rebuild engine proxy for **engineering.glasswallsolutions.com** website
​
- Download OVA file from [here](https://glasswall-sow-ova.s3.amazonaws.com/vms/Engineering-website/glasswall-engineering.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYVTP3BV6R%2F20201116%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T155056Z&X-Amz-Expires=31536000&X-Amz-SignedHeaders=host&X-Amz-Signature=f3e4fd8bac2f4b6bb91169496527bcceb7781cf247d4fec4cfc3676d200aa372)

- Open VirtualBox and import downloaded OVA file: glasswall-engineering.ova

- Once OVA is imported, go to Settings>Network>Adapter 2 
 
  `Name: VirtualBox Host-Only Ethernet Adapter`

  `Attached to: Host-Only Adapter`

- Start Glasswall Engineering VM
​
- Login (username: **user**, password: **secret**)
​
- In command line shell, type:
  
  `ip a show eth1`
​
- Check the ip address for eth1 (this address to be used in the following step)
​
- If you need to set custom ICAP url, modify **./k8-reverse-proxy/stable-src/gwproxy.env** as follows
​
  `nano /home/user/k8-reverse-proxy/stable-src/gwproxy.env`
  
  Find the line that starts with **ICAP_URL=** , and change the value to the desired ICAP server URL 

- Navigate to k8-reverse-proxy/stable-src
  
  `docker-compose down`

  `docker-compose up -d`
​​
- In your hosts file (on Windows: **C:\Windows\System32\drivers\etc**, on MAC/Linux: **/etc/hosts**) add following lines
  
  `<VM IPADDRESS> engineering.glasswallsolutions.com.glasswall-icap.com`

  `<VM IPADDRESS> gw-demo-sample-files-eu1.s3-eu-west-1.amazonaws.com.glasswall-icap.com`
​
- Open any browser and try to access: [engineering.glasswallsolutions.com.glasswall-icap.com](https://engineering.glasswallsolutions.com.glasswall-icap.com)
  
  Add needed exceptions to be able to bypass the SSL Certificate warning.
  
#### Here is the video with above instructions:

[![GW Engineering OVA](https://img.youtube.com/vi/itMyB8-HTMk/0.jpg)](https://youtu.be/vXrL_LYcamo)

- Navigate to Documentation tab > Sample Files and try to download any and verify that file has "Glasswall Approved" watermark

#### Here is the video with above instructions: [Glasswall Engineering Website OVA](https://youtu.be/vXrL_LYcamo)


## Minio Server OVA

- Download the OVA from [here](https://glasswall-sow-ova.s3.eu-west-1.amazonaws.com/vms/Minio-Server/minio_server.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYW4UDSC6T%2F20201116%2Feu-west-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T095417Z&X-Amz-Expires=604740&X-Amz-SignedHeaders=host&X-Amz-Signature=15e1d91a6ac7b149ef2d92ef99928f4101c6a5a11e340c1c666bad6362397f88)

- Open VirtualBox and import downloaded OVA file: minio-server.ova

- Once OVA is imported, go to Settings>Network>Adapter 2
    
  `Name: VirtualBox Host-Only Ethernet Adapter`

  `Attached to: Host-Only Adapter`

- Start Minio Server VM

- Login (username: **user**, password: **secret**)

- In command line, type:
  
  `ip a show eth1`

- Check the ip address for eth1 (this address to be used in the following step)

- In your local hosts file (on win: C:\Windows\System32\drivers\etc, on MAC/Linux: /etc/hosts) add following lines

  `<VM IPADDRESS> minio.server`
Example:

    192.168.56.102 minio.server

- Open any browser and try to access: http://minio.server

- Login to Minio Server (username: **user**, password: **secret_password**)

#### Here is the video with above instructions:

[![Minio server OVA](https://img.youtube.com/vi/itMyB8-HTMk/0.jpg)](https://www.youtube.com/watch?v=itMyB8-HTMk)

## Minio Proxy OVA

- You setup Minio Server as per steps above and Minio Server VM is up and running

- On Minio Server VM flush ip address:

  `sudo ip addr flush eth1`

  `sudo dhclient`

  `ip a show eth1`

- Download the Minio Proxy OVA from [here](https://glasswall-sow-ova.s3.eu-west-1.amazonaws.com/vms/Minio-Server/minio_proxy.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYW4UDSC6T%2F20201116%2Feu-west-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T095741Z&X-Amz-Expires=604740&X-Amz-SignedHeaders=host&X-Amz-Signature=65c8d8ebe4e79374a5cbb84df7c277b8fb9b848977e67ea6bf4f50e9cc5d41ec)

- Open VirtualBox and import downloaded OVA file: minio-proxy.ova

- Once OVA is imported, go to Settings>Network>Adapter 2
    
  `Name: VirtualBox Host-Only Ethernet Adapter`

  `Attached to: Host-Only Adapter`

- Start Minio Proxy VM

- Login (username: **user**, password: **secret**)

- Flush Minio Proxy IP address:
  
  `sudo ip addr flush eth1`

  `sudo dhclient`

  `ip a show eth1`

- Inside Minio Proxy VM, update the /etc/hosts file with flush IP address of Minio Server:
 
  `<Minio Server flushed IPADDRESS> minio.server`

Example:

    192.168.56.102 minio.server

- Run below commands in k8-reverse-proxy/stable-src

  `sudo docker-compose down`

  `sudo docker-compose up -d`

- In your local hosts file (on win: C:\Windows\System32\drivers\etc, on MAC/Linux: /etc/hosts) add following lines:

  `<Minio Server IPADDRESS> minio.server`

  `<Minio Proxy IPADDRESS> minio.server.glasswall-icap.com`

Example:

    192.168.56.102 minio.server
    192.168.56.103 minio.server.glasswall-icap.com

- Access Proxied Minio Server at: http://minio.server.glasswall-icap.com

- Note: It takes some time for page to load

- Login to Minio Proxied Server (username: **user**, password: **secret_password**)

- **Note:** Make sure the Minio Server and Minio Proxy IP addresses are not same. If the IP address is the same, run flush commands on both VMs to get a new IP address.

