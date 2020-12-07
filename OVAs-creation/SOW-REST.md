# SOW-REST VM

Download SOW-REST OVA file from s3: 

## Creating the VM

* Access esxi server with valid credentials   [esxi01.glasswall-icap.com](http://esxi01.glasswall-icap.com) or [esxi02.glasswall-icap.com](http://esxi02.glasswall-icap.com) 

* Create a new Linux, Ubuntu (64-bit) VM with minimal hardware specs (1 CPU , 1 GB ram & 16 GB of Harddisk(remember to make disk Provisioning to be thin provisioned)) 

  ![image](https://user-images.githubusercontent.com/58347752/100459771-b0a60a80-30ce-11eb-959e-018d88a8cf2b.png)

* Set CD/DVD drive is connected at power on and choose the ISO to boot from

  ![image](https://user-images.githubusercontent.com/58347752/100460151-66715900-30cf-11eb-914e-2f802acb5052.png)

* Finish installation and boot the machine with default configuration

* Once you "Power ON" your Machine start with setup. Pay attention to the steps below. 

* In the network configuration, under ens160, edit the IPV4 method to be manual and add the network configuration. Example on image below. This IP addresses are ESXi related and can be obtained from corresponding channel.

  ![Networkconnection](https://user-images.githubusercontent.com/70108899/100768735-82d90280-33fb-11eb-8e1d-f60164fad167.PNG)

* Set the username to be glasswall and set password to agreed password (you can also use `user/secret` in testing purposes)

Once installation is done restart the VM and press enter when it asks to remove the CD

Creating VM on ESXi, video instructions: **https://www.loom.com/share/1b81bef51ea341938bb8dd04a2d62ee9**

## Implementation

- This step can be skipped. Network is already configured in previous section. Configure network to use DHCP on ESXi will not work. 
  
  ```bash
  sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/g' /etc/default/grub
  update-grub
  rm /etc/netplan/*.yml /etc/netplan/*.yaml
  cat > /etc/netplan/network.yaml <<EOF
  network:
    version: 2
    ethernets:
      eth0:
        dhcp4: true
  EOF
  ```


- Install K3s: `curl -sfL https://get.k3s.io | sh -`

- Install helm: `curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash -`

- Clone the repo and change your working directory into the kubernetes directory: `git clone https://github.com/k8-proxy/sow-rest && cd sow-rest/kubernetes`

- Create kube config: `sudo ln -s /etc/rancher/k3s/k3s.yaml ~/.kube/config`

- Execute `./deploy.sh`

- Access the filedrop URL: `https://<VM IP>` and just click login (login details are not requiered)

- This VM once shutdown, can now be exported as OVA file.

## Import the VM

- Download all files from **s3://glasswall-sow-ova/vms/SOW-REST/** (AWS s3 bucket)

- Login to VMware ESXi with a privliged user (i.e: **root**)

- From sidebase choose **Virtual machines**

- Click **Create / Register VM**

- Choose **Deploy a virtual machine from OVF or  OVA file**

- Click **Click to select files or drag/drop** and select the **.ovf**, **.vmdk**, **.nvram** and the **.mf** files downloaded from the S3 bucket 

- Select desired storage and *optionally* tweak VM configuration

- Wait for the import to finish

## Usage

- Start the VM and wait until it's fully booted

- login as **`user`** using the password **`secret`**
* Unless your environment does **not** use DHCP for network configuration,  you should have everything running
  
  If DHCP isn't used or for some reason the VM could not fetch automatic network configuration (this is the case for ESXi VM), you will have to:
  
  - Configure network manually, this can be done by modifying `/etc/netplan/01-netcfg.yaml` , for reference, you can use this example:
    
    ```yaml
    network:
      version: 2
        renderer: networkd
        ethernets:
          eth0:
            addresses:
              - 192.168.0.3/24 # Replace this with desired IP address in CIDR format
            gateway4: 192.168.0.1 # Replace this with desired gateway
              nameservers:
                addresses: [8.8.8.8, 1.1.1.1] # Replace DNS servers if needed
    ```
  
  - run: `sudo netplan apply`
  - Restart k3s service by executing `sudo systemctl restart k3s`
- From a modern web browser, navigate to the VM IP address over HTTPS (i.e: `https://<VM IP>/`) to access the project UI
