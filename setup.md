# OVAs
- Minio Server 
- Minio Proxy 
- Glasswall Engineering Website Proxied
- ICAP Server

## Minio Server OVA

- Download OVA file from [here](https://glasswall-sow-ova.s3.eu-west-1.amazonaws.com/vms/Minio-Server/minio_server.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYW4UDSC6T%2F20201116%2Feu-west-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T095417Z&X-Amz-Expires=604740&X-Amz-SignedHeaders=host&X-Amz-Signature=15e1d91a6ac7b149ef2d92ef99928f4101c6a5a11e340c1c666bad6362397f88)

- Open VirtualBox and import downloaded OVA file: minio-server.ova

- Once OVA is imported, go to Settings>Network>Adapter 2
    
  `Name: VirtualBox Host-Only Ethernet Adapter`

  `Attached to: Host-Only Adapter`

- Start Minio Server VM

- Login (username: **user**, password: **secret**)

- In command line, type:
  
  `ip a show eth1`
​
- Check the ip address for eth1 (this address to be used in the following step)

- In your local hosts file (on win: C:\Windows\System32\drivers\etc, on MAC/Linux: /etc/hosts) add following lines

  `<VM IPADDRESS> minio.server`

- Open any browser and try to access: http://minio.server


## Minio Proxy OVA

- You setup Minio Server as per steps above

- Download OVA file from [here](https://glasswall-sow-ova.s3.eu-west-1.amazonaws.com/vms/Minio-Server/minio_proxy.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYW4UDSC6T%2F20201116%2Feu-west-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T095741Z&X-Amz-Expires=604740&X-Amz-SignedHeaders=host&X-Amz-Signature=65c8d8ebe4e79374a5cbb84df7c277b8fb9b848977e67ea6bf4f50e9cc5d41ec)

- Open VirtualBox and import downloaded OVA file: minio-proxy.ova

- Once OVA is imported, go to Settings>Network>Adapter 2
    
  `Name: VirtualBox Host-Only Ethernet Adapter`

  `Attached to: Host-Only Adapter`

- Start Minio Server VM

- Login (username: **user**, password: **secret**)

- In command line, type:
  
  `ip a show eth1`
​
- Check the ip address for eth1 (this address to be used in the following step)

- If the ip address is the same as for Minio Server, flush minio Proxy one by running
  
  `sudo ip addr flush eth1`

  `sudo dhclient`

  `ip a show eth1`

- Verify if Minio Proxy VM can reach Minio Server
  
  `ping <Minio Server IPADDRESS>`

- On Minio Proxy hosts file (/etc/hosts) add:
  
  `<Minio Server IPADDRESS> minio.server`

- In your local hosts file (on win: C:\Windows\System32\drivers\etc, on MAC/Linux: /etc/hosts) add following lines

  `<Minio Server IPADDRESS> minio.server`

  `<Minio Proxy IPADDRESS> minio.server.glasswall-icap.com`

- Open any browser and try to access: http://minio.server.glasswall-icap.com


## Glasswall Engineering OVA​
- Download OVA file from [here](https://glasswall-sow-ova.s3.amazonaws.com/vms/Engineering-website/glasswall-engineering.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYVTP3BV6R%2F20201116%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T155056Z&X-Amz-Expires=31536000&X-Amz-SignedHeaders=host&X-Amz-Signature=f3e4fd8bac2f4b6bb91169496527bcceb7781cf247d4fec4cfc3676d200aa372)

- Open VirtualBox and import downloaded OVA file: glasswall-engineering.ova
​
- Once OVA is imported, go to Settings>Network>Adapter 2 
 
  `Name: VirtualBox Host-Only Ethernet Adapter`

  `Attached to: Host-Only Adapter`

- Start Glasswall Engineering VM

- Login (username: **user**, password: **secret**)

- In command line, type:
  
  `ip a show eth1`
​
- Check the ip address for eth1 (this address to be used in the following step)
​
- Navigate to k8-reverse-proxy/stable-src
  
  `docker-compose down`

  `docker-compose up -d`
​​
- In your hosts file (on Windows: **C:\Windows\System32\drivers\etc**, on MAC/Linux: **/etc/hosts**) add following lines
  
  `<VM IPADDRESS> engineering.glasswallsolutions.com.glasswall-icap.com`

  `<VM IPADDRESS> gw-demo-sample-files-eu1.s3-eu-west-1.amazonaws.com.glasswall-icap.com`
​
- Open any browser and try to access: https://engineering.glasswallsolutions.com.glasswall-icap.com
  
  Add needed exceptions to be able to bypass the SSL Certificate warning.
