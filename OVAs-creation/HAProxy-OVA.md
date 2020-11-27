# Creating on ESXI & exporting HAProxy-ICAP OVA\



## Creating the VM

* Access esxi server with valid credentials   [esxi01.glasswall-icap.com](http://esxi01.glasswall-icap.com) 

* Create a new Ubuntu linux (64-bit) VM with minimal hardware specs (1 CPU , 1 GB ram & 16 GB of Harddisk(remember to make disk Provisioning to be thin provisioned  )) 

  ![image](https://user-images.githubusercontent.com/58347752/100459771-b0a60a80-30ce-11eb-959e-018d88a8cf2b.png)

* Also CD/DVD drive is connected at power on and choose the ISO to boot from

  ![image](https://user-images.githubusercontent.com/58347752/100460151-66715900-30cf-11eb-914e-2f802acb5052.png)

* Finish installation and boot the machine with default configuration

* In the network configuration, edit the IPV4 method to be manual and add the network configuration 

  ![image](https://user-images.githubusercontent.com/58347752/100460549-0a5b0480-30d0-11eb-89cb-5cabfeebbefd.png)

* Set the username to be glasswall and the agreed password (same password as the controller VM)

Once installation is done restart the VM and press enter when it asks to remove the CD



## Installation

* Following the steps in this documentation we will install HAProxy to work as a load balancer for ICAP server

  https://github.com/k8-proxy/gp-load-balancer/blob/main/haproxy-icap.md

* Clone this repository and run the script for auto install

```bash
cd
git clone https://github.com/k8-proxy/gp-load-balancer
sudo su -
#Please replace the placeholder with your username
cd /home/<username>/gp-load-balancer
./haproxy.sh
```

* Make sure haproxy is active and running

```bash
systemctl status haproxy.service
```

* To confirm functionality telnet your localhost on port 1344 & press 'Enter' multi times as follow

  ```bash
  telnet localhost 1344
  ```

* It should print the following indicating server : C-ICAP/0.5.6

  ```
  Trying 127.0.0.1...
  Connected to localhost.
  Escape character is '^]'.
                  
  
  ICAP/1.0 400 Bad request
  Server: C-ICAP/0.5.6
  Connection: close
  
  Connection closed by foreign host.
  ```

Or for manual installation or for extra configuration manipulation other than the default ones, please follow the manual steps in the link provided above



## Exporting OVA

* Shut down the machine 
* Open the controller machine (Or from your local machine, just the controller machine speed the things up)
* Run the following command to export the VM with OVA extension, it will be exported in your current working directory.

```bash
ovftool vi://46.165.225.145/HAProxy-ICAP ./HAProxy-ICAP.ova
```

![image](https://user-images.githubusercontent.com/58347752/100462111-7179b880-30d2-11eb-93df-ccd893478fe7.png) 



## Importing OVA to ESXI

* From the controller (or from whatever the machine you have exported the OVA file to) , access the esxi server [esxi01.glasswall-icap.com](http://esxi01.glasswall-icap.com) 
*  Register a new VM and choose to be deployed from OVA or OVF file option
* Upload the OVA file and then finish the installation with default configuration
* Wait the upload to be done and you are good to go.