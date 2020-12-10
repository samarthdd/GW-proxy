## Creating Proxy Rebuild VM on ESXI:

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

* Set the username to be glasswall and the agreed password (same password as the controller VM)

Once installation is done restart the VM and press enter when it asks to remove the CD


## Installation

- In order to start the installation ssh to VM via putty (working directly from ESXi console will not give ability for copy/paste or similar acrions)

### Setting Up VM

- on ESXI, head to controller VM, login and open Firefox
- navigate to ESXI and login > create new VM
- name your VM, and set
    **Guest OS family**: Linux
    **Guest OS Version**: Ubuntu Linux (64-bit)
- Storage and Virtual Hardware can be left at minimum (default)
- Scroll to **CD/DVD Drive 1** > Datastor ISO file > ubuntu-20.04.1-live-server-amd64.iso 
- Review VM settings > Finish

### Configuring VM

- Power on VM > Pick settings for VM (language, username & password install openssh, etc.)
- when asked to reboot now > power off VM > Actions > Edit Settings > Remove **CD/DVD Drive 1**
- Now, Power on & let the OS finish setting up, after which you wil be able to login
- Run `ip a` and find the name of the first network interface after loopback, which in this case is `ens160`
- `cd /etc/netplan` & run `ls` to check the files available (there should only be 1), so we'll modify it with `sudo vi $name_of_file)` and modify it to be:
    ```
    network:
      version: 2
      renderer: networkd
      ethernets:
        ens160:
        dhcp4: no
        addresses:
            - 91.109.25.88/27
        gateway4: 91.109.25.94
        nameservers:
            addresses: [8.8.8.8]
    ```
- Run `sudo netplan apply`
- In the VM, you'll be able to ping the gateway and have access to internet

- Install docker by:
    ```
    sudo apt update

    sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    
    sudo apt update
    
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    ```
- Install rancher by:
    ```
    docker run -d --restart=unless-stopped -p 8080:80 -p 8443:443 --privileged rancher/rancher:latest
  ```

- To access rancher, in your loaclhost machine's browser, you can navigate to the VM's IP (type `ip a` in case you are not sure what it is) or in this case, `https://<VM IP>:8443`, and setup the credentials with (username: , password: ).

- If you in any instance encount with "Network connection issues" try reloading.

- Give the rancher url as `https://172.17.0.1:8443` so that the IP of the rancher server remains the same when VMs are created using the OVA and doesn't depend on the public IP of the vm. If you experience some issues with reloading after the change, just type agian initial URL, `https://<VM IP>:8443` and continue with the setup.

- Create a new cluster in the rancher by going to "Add cluster" and selecting the option of "Existing Nodes". 

- Give some name to the cluster and on the bottom of the page click "NEXT".

- In the next page, select etcd, controlplane and worker. Click on "Show advanced options" in right corner to give the public IP of the node as 172.17.0.1 and run the command given by rancher on the VM. And on Rancher UI click "DONE"

    Command example: 

    `sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.5.3 --server https://172.17.0.1:8443 --token x87g9k76cmh5r5htlzp6cvwckhkt9hb7dl8gs6r7d5fcpjgfqz7sqm --ca-checksum 192fb5f7702a308654d8060bafd47cf89d44490e54086d52ce4db8bb75db7039 --address 172.17.0.1 --etcd --controlplane --worker`


- It takes 10-15 minutes until all containers are up and the cluster is healthy. In case you get "refused to connect" site will reload itself.

![image](https://user-images.githubusercontent.com/70108899/100937725-bbf49e00-34f3-11eb-92b0-9a25ef3e7a99.png)

- Once the cluster is healthy and active, select the cluster and click on Kubeconfig File. Copy the content of Kubeconfig and paste in `~/.kube/config` file of the VM. 

- Install kubectl and helm by running:
    ```
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

    chmod +x ./kubectl

    sudo mv ./kubectl /usr/local/bin/kubectl

    curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -

    sudo apt-get install apt-transport-https --yes

    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

    sudo apt-get update

    sudo apt-get install helm -y
    ```

- Test the connectivity to the kubernets cluster by running `kubectl get nodes`

- Clone the proxy-rebuild repository (https://github.com/k8-proxy/s-k8-proxy-rebuild.git) and navigate to s-k8-proxy-rebuild/stable-src folder. 

- Follow the steps [here](https://github.com/k8-proxy/s-k8-proxy-rebuild/tree/master/stable-src#apps-deployment) to deploy the helm chart for setting up proxy for a given website.

## Exporting OVA
- shut down the machine
- Open the controller machine (Or from your local machine, just the controller machine speed the things up) and run 
    ```
    ovftool vi://46.165.225.145/proxy-rebuild ./proxy-rebuild.ova
    ```
- Or click **Export** button under the **actions** of the VM to export and download the OVF and vmdk

## Imorting OVA and setup proxy for a website
- Download the OVA from [here](https://glasswall-sow-ova.s3.amazonaws.com/vms/proxy-rebuild/proxy-rebuild.ova?AWSAccessKeyId=AKIA3NUU5XSYVTP3BV6R&Signature=dtziT6Pbep9%2BmXosxGFo%2BBNnNkI%3D&Expires=1607594681
)
- Open VMware > Open A Virtual Machine > Pick downloaded OVA file

- Be aware of the following errors:
![image](https://user-images.githubusercontent.com/70108899/101050857-1ee24580-3585-11eb-90e3-6701379b769a.png)

![image (1)](https://user-images.githubusercontent.com/70108899/101050996-489b6c80-3585-11eb-9865-f0204f00fa47.png)
- Before starting the VM, 
    - make sure a network adapter is attached to the VM
- Start Proxy Rebuild VM
- Login (username:, password: )
- Run below command after updating the IP address of the VM and gateway IP address.
    ```
    sudo python3 configure_ip.py -i 192.168.56.91 -g 192.168.56.1
    ```
- Go to `~/s-k8-proxy-rebuild/stable-src/` folder and run `setup.sh` to upgrade the helm release with the ICAP server IP address we need to use by the proxy.
    ```
    cd ~/s-k8-proxy-rebuild/stable-src/
    ./setup.sh <ICAP server IP>
    ```
- If the nginx or squid needs few DNS names to be assigned to an IP address, host aliases(below line) can be added to the setup.sh script. For example if `www.glasswallsolutions. local` and `www.glasswallsolutions.local` domains should be assigned to `192.168.56.90` IP, add below line to setup.sh script:
    ```
    --set hostAliases."192\\.168\\.56\\.90"={"glasswallsolutions.local"\,"www.glasswallsolutions.local"} \
    ```
- Depending on which websites need the proxy, update the above command with the domain names.
- Open any browser and access [www.glasswallsolutions.com](https://www.glasswallsolutions.com) after adding the IP address of this server to this DNS in hosts file.
