## Glasswall Wordpress OVA
​
Glasswall Wordpress OVA for demoing Glasswall Wordpress local downloading file for **example.local** website

### Make sure that ICAP Server OVA is imported into VM and is started. Glasswall Enfineering OVA is dependent on previous one.
- Download OVA file from [here](https://glasswall-sow-ova.s3.eu-west-1.amazonaws.com/vms/Engineering-website/glasswall-engineering.ova?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3NUU5XSYVTP3BV6R/20201123/eu-west-1/s3/aws4_request&X-Amz-Date=20201123T103128Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=81014796a8554b5847e4d844530e578b4782ea7f10859113c5b1bd03d984322e)

- Open VirtualBox/VMware workstation and import downloaded OVA file: glasswall-wordpress.ova

- Start Glasswall wordpress VM
​
- Login (username: **glasswall**, password: **glasswall**)

- By default, Glasswall wordpress VM is web server and use static IP. Network mode is Brigde 
​​​
- Change network IP mapping to your network following command :
```
glasswall@glasswallwordpress:~$ sudo nano /etc/netplan/00-installer-config.yaml
```
- File 00-installer-config.yaml look like : 
```
# This is the network config written by 'subiquity'
network:
  ethernets:
    ens33:
      addresses: [91.109.25.89/27]
      gateway4: 91.109.25.94
      nameservers:
        addresses: [8.8.8.8]
  version: 2
```
- Change `addresses` to your network example `[192.168.1.100/24]`

- Change `gateway` to your Access point/gateway address, example `192.168.1.1`

- `Nameserver` : change to your DNS nameservers or can use `8.8.8.8` as default 

- Press Ctrl- O to save and Ctrl - X to exit

- Apply network change following command :
```
glasswall@glasswallwordpress:~$ sudo netplan apply
```
- Check to make sure network change successful
```
glasswall@glasswallwordpress:~$ ifconfig
ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 91.109.25.89  netmask 255.255.255.224  broadcast 91.109.25.95
        inet6 fe80::20c:29ff:feec:366e  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:ec:36:6e  txqueuelen 1000  (Ethernet)
        RX packets 114325  bytes 6960351 (6.9 MB)
        RX errors 0  dropped 921  overruns 0  frame 0
        TX packets 1323  bytes 834981 (834.9 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```
- Add domain `example.local` point to Glasswall wordpress VM to your hosts file ( `C:\Windows\System32\drivers\etc\hosts` on Windows , `/etc/hosts` on Linux ) 

- Open browser and go to website `http://example.local`, click to download PDF file
  
- You can edit/manager the site by go to admin page `http://example.local/wp-admin`, username and password are them same with VM login credential 
#### Here is the video with above instructions: [Glasswall wordpress Website OVA](https://youtu.be/NKiSmCmM2Dc)
