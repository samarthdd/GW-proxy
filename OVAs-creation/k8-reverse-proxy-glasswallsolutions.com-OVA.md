#VMWare OVA creation for glasswallsolutions.com

This manual is the step by step OVA creation and deployment for:

[glasswallsolutions.com.glasswall-icap.com](https://glasswallsolutions.com.glasswall-icap.com/)

[www.glasswallsolutions.com.glasswall-icap.com](https://www.glasswallsolutions.com.glasswall-icap.com/)

[glasswallsolutions.com](https://glasswallsolutions.com/)

[www.glasswallsolutions.com](https://www.glasswallsolutions.com/)If you have OVA you can go to Create a Virtual machine on ESX Server from OVA.

The purpose of this document is to provide a manual about installing any Glasswall solution on ESX Server and create/install OVA also.

# Create a Virtual machine on the ESX Server.

1.  Log in to the ESX server

2.  Choose **Create / Register VM**

3.  Choose to **Create a new virtual machine** and click Next

4.  Choose **Name** corresponding to the function e.g. glasswallsolutions.com

5.  Select **Guest OS family** (default Linux)

6.  Select **Guest OS version** (default Ubuntu Linux (64-bit))

7.  Click **Next**.

8.  Choose **Standard** and default datastore and click **Next**.

9.  Do not use more than 1 GB RAM and 16 GB Hard disk space.

10. **SCSI Controller 0** choose **VMware Paravirtual**.

11. Use a single network and a single disk as possible.

12. Remove the USB controller.

13. **CD / DVD Drive 1** -- select **Datastore ISO file** with the operating system (recommended Ubuntu 20.x).

14. Click **Next** and **Finish**.

# Install the Operating System in VM

1.  Choose VM and press **Power on.**

2.  After machine bootup chooses **Console** / **Open browser console**.

3.  Install Operating system using the following:

    -   Connect using SSH.

    -   Apt-get update.

    -   English US Language and keyboard.

    -   Configure IPV4 manual.

        -   subnet 91.109.25.64/27.

        -   IP: 91.109.25.x (consult slack to free IP and make IP
            reservation on slack).

        -   gateway: 91.109.25.94.

        -   name servers: 8.8.8.8.

    -   username "glasswall".

    -   Use entire disk

    -   Do not use LVM

    -   use complicated password.

    -   Use the corresponding server name to function for the server.

    -   Install SSH.

    -   Install minimum packages.

4.  Update operating system (e.g. Install Operating system using the following:

    -   Connect using SSH.

    -   sudo apt-get update.

5.  Update operating system (e.g. Install Operating system using the following:

    -   Connect using SSH.

    -   sudo apt-get update.

# Deploy Solution and export OVA

6.  Install workloads according to <https://github.com/MariuszFerdyn/gp-jira-website/tree/main/atlassian.net/no-local-dns-changes>. In that point you can follow other website install. Here is a step by step:

    -   Install the dependencies:
```bash
sudo apt install -y curl git
curl https://get.docker.com | bash -
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker $(whoami)
```
-   Prepare the repositories:
```bash
git clone --recursive https://github.com/k8-proxy/k8-reverse-proxy.git
git clone https://github.com/k8-proxy/GW-proxy
wget https://github.com/filetrust/Glasswall-Rebuild-SDK-Evaluation/releases/download/1.117/libglasswall.classic.so -O k8-reverse-proxy/stable-src/c-icap/Glasswall-Rebuild-SDK-Evaluation/Linux/Library/libglasswall.classic.so
cp -rf GW-proxy/OVAs-creation/k8-reverse-proxy-glasswallsolutions.com-OVA/* k8-reverse-proxy/stable-src/
```
-   Delete unnecessary files:
```bash
rm -rf GW-proxy
rm -fr k8-reverse-proxy/upwork-devs/
```
-   Start deployment and container with revers proxy:
```bash
cd k8-reverse-proxy/stable-src/
docker-compose up -d --force-recreate –build
```
7.  Test solution

    -   Modify local host file and test solution using web browser. Instead 91.109.25.87 use proper IP. You can add k8-reverse-proxy-glasswallsolutions.com-OVA/CA.cer to the Trusted Root Certification Authorities to avoid certificate error.
```bash
91.109.25.87 glasswallsolutions.com.glasswall-icap.com
91.109.25.87 www.glasswallsolutions.com.glasswall-icap.com
91.109.25.87 glasswallsolutions.com
91.109.25.87 www.glasswallsolutions.com
```
-   Using ESX console **Shutdown** and then **Power on** the server and check if the solution is working after an unplanned reboot.

8.  Prepare OVA

    -   Delete unnecessary logs and history:
```bash
sudo rm -f /etc/ssh/*.pub
sudo rm -f /etc/ssh/*.key
sudo logrotate --force /etc/logrotate.conf
history -c && history -w

```

-   From ESX console Shut down VM.

-   Choose VM and click **Edit**, under CD/DVD Drive 1 make sure that no any iso is chosen it should be the point to "Host device". Click **Save**.

-   Download and install ovftool.exe tool from
    <https://my.vmware.com/web/vmware/downloads/details?productId=614&downloadGroup=OVFTOOL420>.

-   Export OVA (glasswallsolutions.com is a VM name)
```bash
"C:\Program Files (x86)\VMware\VMware Workstation\OVFTool\ovftool.exe" vi://esxi01.glasswall-icap.com/glasswallsolutions.com glasswallsolutions.com.ova
```
-   Upload exported ova to S3

9.  Delete the VM

10. Deploy OVA

    -   Download OVA

    -   Log-in to the ESX

    -   Choose Create / register VM

    -   Choose Deploy a virtual machine from OVF or OVA file

    -   Enter a name for Virtual Machine

# Create a Virtual machine on ESX Server from OVA.

1.  Log in to the ESX server.

2.  Choose **Create / Register VM**.

3.  Choose **Deploy a virtual machine from OVF or OVA file** and click **Next**.

4.  Choose **Name** corresponding to the function e.g. glasswallsolutions.com and drop OVA file and click **Next**.

5.  Choose **Standard** and default datastore and click **Next**.

6.  Confirm deployments option.

7.  Click **Next** and **Finish** (You can ignore Warning about the
    missing image).

8.  After machine bootup chooses **Console** / **Open browser console**.

9.  Log-in to the machine.

10. isse **sudo vi /etc/netplan/00-installer-config.yaml**and eventually correct network parameters

11. Issue **sudo netplan --debug apply**.

12. Check IP address using **ip a**.

13. Go to the solution container **cd k8-reverse-proxy/stable-src/**.

14. Check status by using **docker-compose ps**.

15. If any of the containers is not running issue **docker-compose up -d --force-recreate**.
