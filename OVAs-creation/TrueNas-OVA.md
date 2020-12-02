# TrueNas Installation in ESXI: 

### Download TrueNas .iso file 
        Link - https://truenas.com/download 

### Upload downloaded .iso file to datastore of vsxi

### Create VM from vsxi 6.7

    1. Click on Create / Register VM
   
    2. Select create new virtual machine and click Next
    
    3. Give some name to VM 
       Select 
           - Guest OS - Linux
           - Guest OS Version - Ubuntu linux(64 bit)
    
    4. Select Storage in next screen and click next
    
    5. Customize settings specifications
            - RAM - 8gb ( Tick reserve all guest memory )
            - Hard disk - Create 3 hard discs , one with 8 gb and other two with 16 gb with all 3 thin provisioned.
            - Click on add another device and select SCSI Controller , select LSI Logic Parallel from dropdown.
            - Expand CD/DVD Media , Select Database ISO file and select TrueNas ISO which was uploaded in first step 
    
    6. Select Next and click finish.
    
### Start VM    
    1. Once you start VM , you will get TrueNas installtion screen and click enter.
    
    2. Next from installtion wizard, select install/upgrade 
    
    3. Next it will ask you which of 3 hard disc to use for installtion, Select DA0 (8 gb)
    
    4. Lastly select install via BIOS.
    
    5. Give a password in next step for your TrueNas
    
    6. Once successfull installtion, you need to reboot system.
    
    7. Finally after the system rebooted, I was presented with a screen that had the IP address for the TrueNAS web interface.
    
    8. From my Chrome Browser, I entered the IP address and was greeted with a login screen. I entered root as the username, and then entered my password.
    
## Export OVF from VM
    Power off the TrueNas VM in vsxi
    Download OVF and vmdk by selecting Actions-->Export
    
## Important Note   
    In case, DNS is not configured,
    From TrueNas web interface,do the following
        - Set appropriate Network Interface 
            1. Click 1
            2. Select vmx0 by clicking 1
            3. Enter n for elete interface?
            4. Enter n for remove current settings
            5. Enter y for Configure interface for DHCP
            6. Give interface name
            7. Enter n for ipv6
            8. Enter y for Configure fail over setting and just enter for all and finish.
            9. Repeat first 3 steps and you will get prompt "Configure ipv4 option?"
            10. Enter y and enter name and give proper ip (ipv4 - 91.109.25.xx/27)
           
        -  You need to setup Default route by clicking 5 ( ipv4 - 91.109.25.94)
        -  Finally reboot to get proper TrueNas IP and on webinterface you will get TrueNas server IP.
 
 ## Export OVA of VM
    * Download OVA tool
    * Shut down the machine 
    * Open the controller machine (Or from your local machine, just the controller machine speed the things up)
    * Run the following command to export the VM with OVA extension, it will be exported in your current working directory.

    Note: the username and password to be provided here are the initial ESXI server credentials  

        ```bash
        ovftool vi://46.165.225.145/TrueNAS ./TrueNAS.ova
        ```
    
    
    
   