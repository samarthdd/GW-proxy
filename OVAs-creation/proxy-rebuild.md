## Creating Proxy Rebuild VM on ESXI:

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
    sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
    sudo apt update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    ```
- Install rancher by:
    ```
    docker run -d --restart=unless-stopped \
    -p 8080:80 -p 8443:443 \
    --privileged \
    rancher/rancher:latest
  ```

- To access rancher, in your host machine's browser, you can navigate to the VM's IP or in this case, `91.109.25.88` and setup the credentials with (username: **admin**, password: **Gl@$$wall**)

- Give the rancher url as `https://172.17.0.1:8443` so that the IP of the rancher server remains the same when VMs are created using the OVA and doesn't depend on the public IP of the vm.

- Create a new cluster in the rancher by selecting the option of "Existing Nodes". In the next page, select etcd, controlplane and worker. Give the public IP of the node as 172.17.0.1 and run the command given by rancher on the VM.

- It takes few minutes, until all containers are up and the cluster is healthy. Once the cluster is healthy and active, select the cluster and click on Kubeconfig File. Copy the content of Kubeconfig and paste in `~/.kube/config` file of the VM. 

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
- Before starting the VM, 
    - go to VM Settings > Add Network Adapter > Netowrk Connection: Host-only
    - make sure the first network adapter is set to **NAT**
- Start Proxy Rebuild VM
- Login (username: **glasswall**, password: **Gl@$$wall**)
- Run helm upgrade/install command to setup proxy for the website. Below is an example to setup proxy for www.glasswallsolutions.com:
    ```
    helm upgrade --install \
    --set image.nginx.repository=pranaysahith/reverse-proxy-nginx \
    --set image.nginx.tag=0.0.1 \
    --set image.squid.repository=pranaysahith/reverse-proxy-squid \
    --set image.squid.tag=0.0.6 \
    --set application.nginx.env.ALLOWED_DOMAINS='glasswallsolutions.com,www.glasswallsolutions.com' \
    --set application.nginx.env.ROOT_DOMAIN='glasswall-icap.com' \
    --set application.nginx.env.SUBFILTER_ENV='' \
    --set application.nginx.env.ICAP_URL='icap://54.77.168.168:1344/gw_rebuild' \
    --set application.squid.env.ALLOWED_DOMAINS='glasswallsolutions.com,www.glasswallsolutions.com' \
    --set application.squid.env.ROOT_DOMAIN='glasswall-icap.com' \
    --set application.squid.env.ICAP_URL='icap://54.77.168.168:1344/gw_rebuild' \
    reverse-proxy chart/
    ```
- Depending on which websites need the proxy, update the above command with the domain names.
- Note, the IP address of the ICAP server can be changed in above command as per need.
- In the VM's terminal, run `ip a ` where you will find the IP address for `ens160`
- Open any browser and access [www.glasswallsolutions.com](https://www.glasswallsolutions.com)
