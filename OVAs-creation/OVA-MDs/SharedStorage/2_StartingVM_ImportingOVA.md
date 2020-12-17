## Shared Storage (TrueNas) OVA Import

## Starting the VM

* Download TrueNas .iso file 

        Link - https://truenas.com/download 

* Upload downloaded .iso file to datastore of ESXi

    * Open and login to ESXI server in browser
    * Go to Storage-->datastore1-->Datastore browser-->Upload
    * Upload the .iso file downloaded in above step.


1. Click on Create / Register VM
   
2. Select create new virtual machine and click Next

3. Give some name to VM 
   Select 
       - Guest OS - other
       - Guest OS Version - FreeBSD 12 or later versions (64-bit)

4. Select proper Storage in next screen and click next

5. Customize settings specifications
    - CPU - 2
    - RAM - 8gb ( select checkbox "Reserve all guest memory (All locked)" )
    - Hard disk - Create 3 hard discs , 
      1. HardDisc 1 - 8 gb and thin provisioned.
      2. HardDisc 2 - 16 gb and thin provisioned.
      3. HardDisc 3 - 16 gb and thin provisioned.
    
    - Click on add another device and select SCSI Controller , select LSI Logic Parallel from dropdown.
    - Expand CD/DVD Media ,Select Datastore ISO file and select TrueNas ISO which was uploaded in earlier step. 

        ![pp](https://user-images.githubusercontent.com/70108899/101371990-b27c8480-38ab-11eb-85eb-98f87b327966.PNG)
        Figure 1: TrueNAS VM Custom settings.
6. Select Next and click finish.

## Importing OVA to ESXI

* From the controller (or from whatever the machine you have exported the OVA file to), access the esxi server
* Register a new VM and choose to be deployed from OVA or OVF file option
* Upload the OVA file and then finish the installation with default configuration
* Wait the upload to be done
* TrueNas VM is now ready to be used