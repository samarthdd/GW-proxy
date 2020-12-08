# Gov-UK offline clone VM

OVF + VMDK hosting a clone of `www.gov.uk`

## Implementation

- Install Ubuntu LTS on a VM, set the username `glasswall`  and password `Gl@$$wall`

- Login to the system

- Make the user a sudoer by running `echo glasswall ALL=(ALL) NOPASSWD: ALL | sudo tee /etc/sudoers.d/glasswall`

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

- Clone the repo , change dir into GW-proxy/OVAs-creation/govuk, and run configure.sh
  
  ```bash
  git clone https://github.com/k8-proxy/GW-proxy
  cd GW-proxy/OVAs-creation/govuk
  ./configure.sh
  ```

- Download the Gov.uk clone archive `wget -O ~/gov_uk.zip https://glasswall-sow-ova.s3-eu-west-1.amazonaws.com/vms/gov-uk/gov_uk.zip`

- Extract the archive into **`/var/www/html`**
  
  ```bash
  cd /var/www/html
  sudo apt install -y unzip
  unzip ~/gov_uk.zip
  # The last command will take some time
  ```

- Power off the VM `sudo poweroff` then export the VM to OVA/OVF

## Import the VM

- Download all files from **s3://glasswall-sow-ova/vms/gov-uk/** (AWS S3 bucket)

- Login to VMware ESXi with a privliged user (i.e: **root**)

- From sidebase choose **Virtual machines**

- Click **Create / Register VM**

- Choose **Deploy a virtual machine from OVF or  OVA file**

- Click **Click to select files or drag/drop** and select the **.ova** file downloaded from the S3 bucket 

- Select desired storage and *optionally* tweak VM configuration

- Wait for the import to finish

## Usage

- Start the VM and wait until it's fully booted

- login as **`glasswall`** using the password **`Gl@$$wall`**
* Unless your environment does **not** use DHCP for network configuration,  you should have everything running, you can get your VM ip by running `ip addr show`
  
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
- Run `netplan apply` to apply new network configuration

- Edit the client computer hosts file, append the following to the end of the file, replace the placeholder ip address with the VM ip address
  
  ```
  192.168.0.3 www.gov.uk assets.publishing.service.gov.uk www.gov.uk.local assets.publishing.service.gov.uk.local
  ```

- Download ca.pem from the VM home folder, this can be done by running `scp`  from your client computer as in the following example, replace the placeholder IP with the VM IP
  
  ```bash
  scp glasswall@192.168.0.3
  ```

- In your certificate store (for example, Firefox certificates store) import from a modern web browser, navigate to the VM IP address over HTTPS (i.e: **https://www.gov.uk** ) to access the project UI
