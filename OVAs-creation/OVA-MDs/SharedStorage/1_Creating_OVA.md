### This MD contains details on how to create Shared Storage (TrueNas) OVA from scratch.
### Prerequisite: VM on ESXi is created (first part of 2_StartingVM_ImportingOVA.md)


1. Once you start VM , you will get TrueNas installtion screen and click enter.
        
      ![image](https://user-images.githubusercontent.com/64204445/101630468-e9d46800-3a48-11eb-928b-b197b4ef53bc.png)
            
      Figure 2: TrueNAS Installtion Screen
        
2. Next from installtion wizard, select install/upgrade 

3. Next it will ask you which of 3 hard disc to use for installation, Select the one with 8 gb,by pressing spacebar to select. 

4. Give a password for your TrueNas ( This password will be used for TrueNas Ui login in browser )

5. Lastly select boot via BIOS.

6. After successfull installation, reboot the system.

7. After the system is rebooted,you should get below screen.

    ![image](https://user-images.githubusercontent.com/64204445/101628021-36b63f80-3a45-11eb-913e-65547fc7d6c2.png)
    
      Figure 3: TrueNAS Gui 
           
## Configure IP and Gateway   

From TrueNas web interface,do the following   

1. Enter `1` to "Configure Network Interface?"
2. Select "vmx0" by entering `1`
3. Enter `n` for "delete interface?" If this question is not shown move to step 4
4. Enter `n` for "Remove current settings?"
5. You will get prompt "Configure ipv4 option?"
6. Enter `y` and enter Interface name and give proper ipv4 with subnet (ipv4 example - 91.109.25.xx/26)
7. Enter `n` for "Configure IPv6?"
8. Enter `n` for "Configure failover settings?". After this you will redirected to Figure 3.

    Note : if you get "Configure network for DHCP?" Enter `y` 

   ![image](https://user-images.githubusercontent.com/64204445/101627046-c78c1b80-3a43-11eb-8d86-1a07a017f9cb.png)  
        Figure 4 : Sequence of commands to set IPv4
                    
9. In TrueNas GUI Set Default route by entering `4`
      1. Configure IPv4 Default Route ? Enter `y`
      2. Enter IPv4 gateway  
      3. Configure IPv6 Default Route? Enter `n`
      
      ![image](https://user-images.githubusercontent.com/64204445/101626935-a4616c00-3a43-11eb-9a63-a4f75820b01f.png)  
        Figure 5 : Gateway configaration
        
10. Finally reboot by entering `10`
            
11.  Open the Network Interface IP in browser to open TrueNAS UI


     Open https://{Network Interface IPv4}
        
        username: root
        ( The password will be the one entered in step 4 )
        
   ![image](https://user-images.githubusercontent.com/64204445/101631967-35881100-3a4b-11eb-81f6-90304c9ecc78.png)

        
## Export OVA of VM
1. Download OVA tool
2. Shut down the machine 
3. Open the controller machine (Or from your local machine, just the controller machine speed the things up)
4. Run the following command to export the VM with OVA extension, it will be exported in your current working directory.

Note: the username and password to be provided here are the initial ESXI server credentials  

     ovftool vi://46.165.225.145/TrueNAS ./TrueNAS.ova