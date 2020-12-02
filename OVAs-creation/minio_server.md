## Creating Minio Server on ESXI:

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

- run `ip a` and find the name of the first network interface after loopback, which in this case is `ens160`
- `cd /etc/netplan` & run `ls` to check the files available (there should only be 1), so we'll modify it with `sudo vi $name_of_file)` and modify it to be:
    ```
    network:
    version: 2
    renderer: networkd
    ethernets:
        ens160:
        dhcp4: no
        addresses:
            - 91.109.25.79/27
        gateway4: 91.109.25.94
        nameservers:
            addresses: [8.8.8.8]
    ```
- run `sudo netplan apply`
- in the VM, you'll be able to ping the gateway and have access to internet
- install docker by:
    ```
    sudo apt update
    ```
    ```
    sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    ```
    ```
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    ```
    ```
    sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   ```
   ```
    sudo apt update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    ```
- install minio server by:
    ```
    sudo docker pull minio/minio:latest
    sudo docker run -d --restart=always -p 80:9000 \
  --name minio1 \
  -v /mnt/data:/data \
  -e "MINIO_ACCESS_KEY=user" \
  -e "MINIO_SECRET_KEY=secret_password" \
  minio/minio server /data
  ```

- in your host machine's browser, you can navigate to the VM's IP or in this case, `91.109.25.79` and login with (username: **user**, password: **secret_password**)


## Exporting OVA
- shut down the machine
- Open the controller machine (Or from your local machine, just the controller machine speed the things up) and run 
    ```
    ovftool vi://46.165.225.145/minio-server ./minio-server.ova
    ```

## Imorting OVA
- Open VMware > Open A Virtual Machine > Pick downloaded OVA file
- Before starting the VM, 
    - go to VM Settings > Add Network Adapter > Netowrk Connection: Host-only
    - make sure the first network adapter is set to **NAT**
- Start Minio Server VM
- Login (username: **glasswall**, password: **Gl@$$wall**)
- In the VM's terminal, run `ip a ` where you will find your main network interface, example `ens160`
- `cd /etc/netplan` & run `ls` to check the files available (there should only be 1), so we'll modify it with `sudo vi $name_of_file)` and modify it to be:
    ```
    network:
    version: 2
    renderer: networkd
    ethernets:
        ens160:
        dhcp4: no
        addresses:
            - 91.109.25.79/27
        gateway4: 91.109.25.94
        nameservers:
            addresses: [8.8.8.8]
    ```
    where under `addresses` you give your VM an IP from your network, example: `192.168.43.100`, followed by a gateway IP, example `192.168.43.1`
- run `sudo netplan apply`
- In your local hosts file (win: C:\Windows\System32\drivers\etc, on MAC/Linux: /etc/hosts), add:
    ```
    <VM IP_ADDRESS> minio.server
    ```
    **Example:** `192.168.66.128 minio.server`
- Open any browser and access [minio.server](http://minio.server)
- Login to Minio Server 
