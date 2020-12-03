# SOW-REST VM

OVF + VMDK for [k8-proxy/sow-rest](https://github.com/k8-proxy/sow-rest) (kubernetes flavor), all files are upload to s3://glasswall-sow-ova/vms/SOW-REST/

## Implementation

- Install Ubuntu LTS on a VM, set the username `user`  and password `secret`

- Login to the system

- Make the user a sudoer by running `echo user ALL=(ALL) NOPASSWD: ALL | sudo tee /etc/sudoers.d/user`

- Configure network to use DHCP
  
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

- Install K3s by running `curl -sfL https://get.k3s.io | sh -`

- Clone the repo and change your working directory into the kubernetes directory `git clone https://github.com/k8-proxy/sow-rest && cd sow-rest/kubernetes`

- Execute `./deploy.sh`

- Power off the VM `sudo poweroff` then export the VM to OVA/OVF

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
  
  If DHCP isn't used or for some reason the VM could not fetch automatic network configuration, you will have to:
  
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
  
  - Restart k3s service by executing `sudo systemctl restart k3s`
- From a modern web browser, navigate to the VM IP address over HTTPS (i.e: **https://192.168.0.3/** ) to access the project UI
