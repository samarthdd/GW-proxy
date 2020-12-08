# TrueNas Installation in ESXI: 

### Download TrueNas .iso file 
        Link - https://truenas.com/download 

### Upload downloaded .iso file to datastore of ESXi

### Create VM from vsxi 6.7

    1. Click on Create / Register VM
   
    2. Select create new virtual machine and click Next
    
    3. Give some name to VM 
       Select 
           - Guest OS - other
           - Guest OS Version - FreeBSD 12 or later versions (64-bit)
    
    4. Select Storage in next screen and click next
    
    5. Customize settings specifications
            - CPU - 2
            - RAM - 8gb ( Tick reserve all guest memory )
            - Hard disk - Create 3 hard discs , one with 8 gb and other two with 16 gb with all 3 thin provisioned.
            - Click on add another device and select SCSI Controller , select LSI Logic Parallel from dropdown.
            - Expand CD/DVD Media , Select Database ISO file and select TrueNas ISO which was uploaded in first step 
    
![pp](https://user-images.githubusercontent.com/70108899/101371990-b27c8480-38ab-11eb-85eb-98f87b327966.PNG)
    
    6. Select Next and click finish.
    
### Start VM    
    1. Once you start VM , you will get TrueNas installtion screen and click enter.
    
    2. Next from installtion wizard, select install/upgrade 
    
    3. Next it will ask you which of 3 hard disc to use for installtion, Select the one with 8 gb, by navigated and presing spacebar to select. 
    
    4. Give a password for your TrueNas
    
    5. Lastly select boot via BIOS.
    
    6. After successfull installtion, reboot the system.
    
    7. After the system is rebooted, you will get a screen with the IP address for the TrueNAS web interface. Check important note below in case this does not happen. 
    
    8. From Browser, enter the VM IP address. You should get a login screen. Enter `root` as the username, and then entered your password from step 4.
    
    
## Important Note   
In case, DNS is not configured,
From TrueNas web interface,do the following
- Set appropriate Network Interface     
    1. Enter `1`
    2. Select vmx0 by entering `1`
    3. Enter `n` for delete interface? If this question is not shown move to step 4
    4. Enter `n` for remove current settings
    5. Enter `y` for Configure interface for DHCP
    6. You will get prompt "Configure ipv4 option?"
    7. Enter `y` and enter Interface name and give proper ip (ipv4 example - 91.109.25.xx/26)
    8. Enter `n` for configure IPv6?
    9. Enter `n` for Configure failover settings?
           
-  You need to setup Default route by entering `4`
      Enter gateway IPv4 (ex. 91.109.25.94)
   
-  Finally reboot by entering `10` and get proper TrueNas IP and use it to access TrueNas interface.
-  Open the IP in browser and use 'root' as username
 ## Export OVA of VM
    1. Download OVA tool
    2. Shut down the machine 
    3. Open the controller machine (Or from your local machine, just the controller machine speed the things up)
    4. Run the following command to export the VM with OVA extension, it will be exported in your current working directory.

    Note: the username and password to be provided here are the initial ESXI server credentials  

        ```bash
        ovftool vi://46.165.225.145/TrueNAS ./TrueNAS.ova
        ```
    
    
    
   