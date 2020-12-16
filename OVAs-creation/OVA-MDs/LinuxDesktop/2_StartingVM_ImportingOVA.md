## Linux Desktop OVA Import

## Starting the VM

* Access ESXi server with valid credentials 

* Create a new Ubuntu linux (64-bit) VM with:
  * 2 CPU
  * 4 GB ram 
  * 32 GB of Harddisk (set disk Provisioning to be thin provisioned) 

  ![image](https://user-images.githubusercontent.com/58347752/101004090-23006a00-3569-11eb-9052-1f5a9d3dbb99.png)

* Also CD/DVD drive is connected at power on and choose ***UBUNTU DESKTOP ISO*** to boot from

  ![image](https://user-images.githubusercontent.com/58347752/101005217-74a8f480-3569-11eb-8e7d-2fa83835c179.png)

* Finish installation and reboot the VM.

## Importing OVA to ESXI

* From the controller (or from whatever the machine you have exported the OVA file to), access the esxi server
* Register a new VM and choose to be deployed from OVA or OVF file option
* Upload the OVA file and then finish the installation with default configuration
* Wait the upload to be done
* Linux Desktop VM is now ready to be used