# SMB Share Configaration for TrueNAS

   1. Login to TrueNAS 
   2. Go to Accounts and then Groups ,Click Add
       1. Give a name and click Submit
           
           ![image](https://user-images.githubusercontent.com/64204445/102222899-0ae5fe80-3f0a-11eb-821c-aa729769c3ea.png)


   3. Go to Accounts and then Users ,Click Add
       1. Fill in user details.
       2. In Auxilary groups dropdown,choose group you just created in previous step
       3. Select checkbox Write*Group  under Home Directory Permissions 
       4. Select checkbox Permit Sudo under Authentication
           
           ![image](https://user-images.githubusercontent.com/64204445/102223209-67e1b480-3f0a-11eb-82d5-385ce81f5c8c.png)

   4. Next Go to Storage and then Pools 
        1. If Pool is not there, create a Pool by clicking Add option
        2. Once a Pool is available ,right click and click on Add dataset
        
            ![image](https://user-images.githubusercontent.com/64204445/102223357-a24b5180-3f0a-11eb-8bef-f4e1f10bf5b5.png)

        3. Give name to dataset
        4. Change Share Type to SMB 
        5. Click Submit
        
            ![image](https://user-images.githubusercontent.com/64204445/102223455-bee78980-3f0a-11eb-906e-447b246d5a09.png)

   5. Enable SMB Service
        1. Go to Services
        2. Enable SMB
        3. Select checkbox under Start automatically column for SMB
        
            ![image](https://user-images.githubusercontent.com/64204445/102223590-f0605500-3f0a-11eb-895d-e8e6c82f9225.png)
        
   6. Create Share
       1. Go to Sharing and then Windows Shares(SMB)
       2. Click Add 
       3. Select the path of the Dataset
       4. Give a name to SMB share
       5. Click Submit
       
            ![image](https://user-images.githubusercontent.com/64204445/102223752-1d146c80-3f0b-11eb-8021-55203ce98e32.png)
          
   7. Set Permission for dataset
       1. Go to Sharing and then Windows Shares(SMB)
       2. Click on three dot next to specific share which needs to be shared
       3. Select Edit FileSystem Acl
            ![image](https://user-images.githubusercontent.com/64204445/102223884-4503d000-3f0b-11eb-905c-2c3bf9e5f963.png)

       4. Change the Group to the one created above and select Apply Group checkbox under it
       5. Here you can change lot of permission as per requirements.
       6. Click Save
       
            ![image](https://user-images.githubusercontent.com/64204445/102224032-767c9b80-3f0b-11eb-8a0d-855563068030.png)
            
   8. Connect to SMB                 
        1. Mac OS
            - Finder -->  Go --> Connect to Server
            - Enter `smb://<Server_IP or Domain>/share_name`
            - Enter the username and password for the user.
            - Click OK
            - You should be able to connect to the Samba share.
            - Once the connection has successfully completed, a new location will be created in Finder
              
        2. Windows
            - Go to File Explorer
            - Right click on This PC
            - Add a Network Location
            - Click Next
            - Enter the Windows style address of the Samba server and the share name. Windows uses the following form of a Samba URL: `\\your_samba_hostname_or_server_ip\share\`
            - Click Next
            - Enter the username and password for the user.
            - Click OK.
            - File Explorer will now connect to the Samba share. Once the connection has successfully completed, a new location will be created under This PC in File Explorer:
     
            
            
        