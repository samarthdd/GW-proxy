### This MD contains details on how to create GovUk OVA from scratch.
### Prerequisite: VM on ESXi is created (first part of 2_StartingVM_ImportingOVA.md)

- Access the VM

- Clone the repo and run configure.sh from /home/glasswall/GW-proxy/OVAs-creation/govuk
  
  ```bash
  git clone https://github.com/k8-proxy/GW-proxy
  cd GW-proxy/OVAs-creation/govuk
  ./configure.sh
  ```

- Download the Gov.uk clone archive `wget -O ~/gov_uk.zip https://glasswall-sow-ova.s3-eu-west-1.amazonaws.com/vms/gov-uk/gov_uk.zip`

- Extract the archive into **`/var/www/html`**, but before that create directory www and html inside 

  ```bash
  sudo apt install -y unzip
  unzip ~/gov_uk.zip
  # This last command will take some time
  ```
- After extracting the archive correctly, delete the archive to save space `rm ~/gov_uk.zip`

- Power off the VM `sudo poweroff` then export the VM to OVA/OVF