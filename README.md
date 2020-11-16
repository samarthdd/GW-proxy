# Production websites 

Please refer to wiki for the latest information: https://github.com/k8-proxy/GW-proxy/wiki/Production-websites


## OVAs

## Setup Minio server using virtualbox and OVA

Download the OVA from [here](https://glasswall-sow-ova.s3.eu-west-1.amazonaws.com/vms/Minio-Server/minio_server.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYW4UDSC6T%2F20201116%2Feu-west-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T095417Z&X-Amz-Expires=604740&X-Amz-SignedHeaders=host&X-Amz-Signature=15e1d91a6ac7b149ef2d92ef99928f4101c6a5a11e340c1c666bad6362397f88)

After importing the OVA to virtualbox, make sure network adaptor 1 has "NAT" and adaptor 2 has "VirtualBox Host-Only Ethernet Adaptor"

Once the VM is started, open the IP address of the VM in browser and it should open minio server.

credentials are -

username: user

password: secret_password

Update the /etc/hosts file with the IP address and a DNS name

Example:

    ```
    192.168.56.102 minio.server
    ```

Once the hosts file is updated, minio can be accessed at http://minio.server from browser.

## Setup proxy for minio server

Download the OVA from [here](https://glasswall-sow-ova.s3.eu-west-1.amazonaws.com/vms/Minio-Server/minio_proxy.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYW4UDSC6T%2F20201116%2Feu-west-1%2Fs3%2Faws4_request&X-Amz-Date=20201116T095741Z&X-Amz-Expires=604740&X-Amz-SignedHeaders=host&X-Amz-Signature=65c8d8ebe4e79374a5cbb84df7c277b8fb9b848977e67ea6bf4f50e9cc5d41ec)

After importing the OVA to virtualbox, make sure network adaptor 1 has "NAT" and adaptor 2 has "VirtualBox Host-Only Ethernet Adaptor"

Once the VM is started, update the /etc/hosts file inside the VM with IP address of above server and DNS name as `minio.server`

Example:

    ```
    192.168.56.102 minio.server
    ```

In the host machine update the /etc/hosts file with IP address of this server and DNS name as `minio.server.glasswall-icap.com`

Example:

```
192.168.56.103 minio.server.glasswall-icap.com
```

Proxied minio server can be now accessed at http://minio.server.glasswall-icap.com

Note: Make sure the IP addresses of above 2 servers are not same. If the IP address is same, run below commands on a VM to get a new IP address.

```
sudo ip addr flush all
sudo dhclient
```
