# Creating & exporting gov.uk offline website OVA on VMware ESXI


## Creating the VM

* Access esxi server with valid credentials   [esxi01.glasswall-icap.com](http://esxi01.glasswall-icap.com) 

* Create a new Photon linux (64-bit) VM with minimal hardware specs (1 CPU , 2 GB ram & 10 GB of Harddisk(remember to make disk Provisioning to be thin provisioned  )) 

  ![image](https://user-images.githubusercontent.com/58347752/100459771-b0a60a80-30ce-11eb-959e-018d88a8cf2b.png)

* Also CD/DVD drive is connected at power on and choose the ISO to boot from

  ![image](https://user-images.githubusercontent.com/58347752/100460151-66715900-30cf-11eb-914e-2f802acb5052.png)

* Finish installation and boot the machine with default configuration

* Set the username to be root and the agreed password (same password as the controller VM)

Once installation is done restart the VM and press enter when it asks to remove the CD

## Setting up network, enable docker and install git

### Seting network following commands:

- Get list network interface
```
>ip a
# you should get network interface like :
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:0c:29:50:a3:ec brd ff:ff:ff:ff:ff:ff
    altname eno1
    altname enp11s0
    altname ens192
    inet 91.109.25.89/27 brd 91.109.25.95 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe50:a3ec/64 scope link
       valid_lft forever preferred_lft forever
```
- Config network IP address
```	   
>cd /etc/systemdnetwork
#by default, network config file is 99-dhcp-en.network

>vi 99-dhcp-en.network
# if your system use dhcp, do not change anything
# if your system use static IP, change the file follow example below:
[Match]
Name=eth0

[Network]
Address=91.109.25.89/27
Gateway=91.109.25.94
DNS=8.8.8.8
#Save and exit vi
```
- Restart network service
```
>systemctl restart systemd-networkd
>ip a
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:0c:29:50:a3:ec brd ff:ff:ff:ff:ff:ff
    altname eno1
    altname enp11s0
    altname ens192
    inet 91.109.25.89/27 brd 91.109.25.95 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe50:a3ec/64 scope link
       valid_lft forever preferred_lft forever
```
### Enable docker and install git

- After network configuration, restart docker service to enable it
```
systemctl restart docker
docker version 
# you should get docker infor like :
Client: Docker Engine - Community
 Version:           19.03.10
 API version:       1.40
 Go version:        go1.14.8
 Git commit:        9424aea
 Built:             Tue Nov  3 22:45:58 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.10
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.14.8
  Git commit:       9424aea
  Built:            Tue Nov  3 22:46:58 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
 ....
```
- Install git
```
tdnf install git
```

### Installation

- Clone icap client repo
```
git clone https://github.com/k8-proxy/icap-client-docker.git
#Go to docker folder
cd icap-client-docker/
```
- Install docker icap client
```
docker build -t c-icap-client .
```
- Check docker image is already
```
docker image ls
# should be like:
REPOSITORY                      TAG                 IMAGE ID            CREATED             SIZE
c-icap-client                   latest              7ec35e673ba9        20 hours ago        1.2GB
gcc                             latest              4d3d1ec24e9e        2 weeks ago         1.19GB
glasswallsolutions/k8-centos7   latest              431852dc2eb5        3 weeks ago         419MB
```
- Test docker icap-client 
```
#you should upload any pdf file to your directory ( like /root), I upload file Execute+Java+Script_JS_PDF.pdf for testing
#Make sure have any stable ICAP server, I use ICAP-server 54.77.168.168 for this test
#Run command below:
docker run -v /root:/root --network host c-icap-client -i 54.77.168.168 -p 1344 -s gw_rebuild -f /root/Execute+Java+Script_JS_PDF.pdf -o /root/clean.pdf -v
#output like:
ICAP server:54.77.168.168, ip:91.109.25.89, port:1344


ICAP HEADERS:
        ICAP/1.0 200 OK
        Server: C-ICAP/0.5.6
        Connection: keep-alive
        ISTag: CI0001-2.1.1
        Encapsulated: res-hdr=0, res-body=207

RESPMOD HEADERS:
        HTTP/1.0 200 OK
        Date: Wed Dec  9 15:38:51 2020
        Last-Modified: Wed Dec  9 15:38:51 2020
        Content-Length: 383912
        Via: ICAP/1.0 mvp-icap-service-5dbb694956-gccdf (C-ICAP/0.5.6 Glasswall Rebuild service )
#check to make sure file clean.pdf is created
ls -l
-rwxr----- 1 root root 383912 Dec  9 15:08 clean.pdf
-rw-r----- 1 root root 386176 Dec  8 10:17 Execute+Java+Script_JS_PDF.pdf
```

## Exporting OVA

* Shut down the machine 
* Open the controller machine (Or from your local machine, just the controller machine speed the things up)
* Run the following command to export the VM with OVA extension (change to corresponding ESXI IP/URL and VM name), it will be exported in your current working directory.

Note: the username and password to be provided here are the initial ESXI server credentials  

```bash
ovftool vi://46.165.225.145/icap-client icap-client.ova
```

## Importing OVA and test icap-client

- Download OVA file from [here](https://glasswall-sow-ova.s3-eu-west-1.amazonaws.com/vms/icap-client/icap_client.ova)

- From the controller (or from whatever the machine you have exported the OVA file to) , access the esxi server 

- Register a new VM and choose to be deployed from OVA or OVF file option

- Upload the OVA file and then finish the installation with default configuration

- Wait the upload to be done and you are good to go.

- By default, you can login with user/password: root/Gl@$$wall
​​​
- Get ethernets interface
```
$ ip a
# get the network interface name for example eth0
```
- Change network IP mapping to your network following commands :
```
cd /etc/systemd/network
ls
#network config file will be listed like:
99-static-en.network
#Edit network file 
vi 99-static-en.network
#press 'i' for edit mode
# if your network system use dhcp, change the file to dhcp mode like example below:
[Match]
Name=eth0

[Network]
DHCP=yes

# if your network system use static IP, change the file follow example below:
[Match]
Name=eth0

[Network]
Address=91.109.25.89/27
Gateway=91.109.25.94
DNS=8.8.8.8
#Press 'ESC' to escape edit mode, press ':wq' to save and exit vi
```
- Restart network service
```
>systemctl restart systemd-networkd
>ip a
...
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:0c:29:50:a3:ec brd ff:ff:ff:ff:ff:ff
    altname eno1
    altname enp11s0
    altname ens192
    inet 91.109.25.89/27 brd 91.109.25.95 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe50:a3ec/64 scope link
       valid_lft forever preferred_lft forever
	   ...
```
- After network configuration, restart docker service to enable it
```
systemctl restart docker
docker version 
# you should get docker infor like :
Client: Docker Engine - Community
 Version:           19.03.10
 API version:       1.40
 Go version:        go1.14.8
 Git commit:        9424aea
 Built:             Tue Nov  3 22:45:58 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.10
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.14.8
  Git commit:       9424aea
  Built:            Tue Nov  3 22:46:58 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
 ....
```
- Check docker image is already
```
docker image ls
# should be like:
REPOSITORY                      TAG                 IMAGE ID            CREATED             SIZE
c-icap-client                   latest              7ec35e673ba9        20 hours ago        1.2GB
gcc                             latest              4d3d1ec24e9e        2 weeks ago         1.19GB
glasswallsolutions/k8-centos7   latest              431852dc2eb5        3 weeks ago         419MB
```
- Test docker icap-client 
```
cd ~
#you should upload/use any file in your directory ( like /root), I upload file Execute+Java+Script_JS_PDF.pdf via ssh for testing
#Make sure we have a stable ICAP server, I use ICAP-server 54.77.168.168 for this test
#Run command below:
docker run -v /root:/root --network host c-icap-client -i 54.77.168.168 -p 1344 -s gw_rebuild -f /root/Execute+Java+Script_JS_PDF.pdf -o /root/clean.pdf -v
#Output like:
ICAP server:54.77.168.168, ip:91.109.25.89, port:1344


ICAP HEADERS:
        ICAP/1.0 200 OK
        Server: C-ICAP/0.5.6
        Connection: keep-alive
        ISTag: CI0001-2.1.1
        Encapsulated: res-hdr=0, res-body=207

RESPMOD HEADERS:
        HTTP/1.0 200 OK
        Date: Wed Dec  9 15:38:51 2020
        Last-Modified: Wed Dec  9 15:38:51 2020
        Content-Length: 383912
        Via: ICAP/1.0 mvp-icap-service-5dbb694956-gccdf (C-ICAP/0.5.6 Glasswall Rebuild service )
#check to make sure file clean.pdf is created
ls -l
-rwxr----- 1 root root 383912 Dec  9 15:08 clean.pdf
-rw-r----- 1 root root 386176 Dec  8 10:17 Execute+Java+Script_JS_PDF.pdf
```  

