# Creating & exporting gov.uk offline website OVA on VMware ESXI


## Creating the VM

* Access esxi server with valid credentials   [esxi01.glasswall-icap.com](http://esxi01.glasswall-icap.com) 

* Create a new Ubuntu linux (64-bit) VM with minimal hardware specs (1 CPU , 2 GB ram & 20 GB of Harddisk(remember to make disk Provisioning to be thin provisioned  )) 

  ![image](https://user-images.githubusercontent.com/58347752/100459771-b0a60a80-30ce-11eb-959e-018d88a8cf2b.png)

* Also CD/DVD drive is connected at power on and choose the ISO to boot from

  ![image](https://user-images.githubusercontent.com/58347752/100460151-66715900-30cf-11eb-914e-2f802acb5052.png)

* Finish installation and boot the machine with default configuration

* In the network configuration, edit the IPV4 method to be manual and add the network configuration 

  ![Networkconnection](https://user-images.githubusercontent.com/70108899/100768735-82d90280-33fb-11eb-8e1d-f60164fad167.PNG)

* Set the username to be glasswall and the agreed password (same password as the controller VM)

Once installation is done restart the VM and press enter when it asks to remove the CD

## Download gov.uk website

- There is a lot of tools to clone gov.uk website, we can use https://www.cyotek.com/cyotek-webcopy on windows, or we can use Glasswall Crawling Tool from here https://github.com/NourEddineX/k8-website-mass-file-download/tree/master/service
- Size of gov.uk offline website is large ( over 15GB), for testing purpose, we should not try to download all. I give a abridged version [here](https://github.com/hongson1981/sharefile/raw/main/govuk.zip) for testing.

- To download gov.uk testing file:
```
wget https://github.com/hongson1981/sharefile/raw/main/govuk.zip
```
- Unzip file
```
sudo apt install unzip #incase you have not installed unzip)
unzip govuk.zip
```

## Installation

- To install Apache server, use following command:

```bash
sudo apt update
sudo apt install -y apache2
```
After letting the command run, all required packages are installed and we can test it out by typing in our IP address for the web server.

- Copy directory `govuk` above  to `/var/www/`
```
sudo cp -R <path-of-govuk> /var/www/
```
- Go into the configuration files directory and create `govuk.conf` file:
```
cd /etc/apache2/sites-available/
sudo cp 000-default.conf govuk.conf
```
- Edit the configuration file:
```
sudo nano govuk.conf
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

```
- Uncomment `ServerName www.example.com` and change it to `ServerName www.gov.uk.local`

- Change `DocumentRoot /var/www/html` to `DocumentRoot /var/www/govuk`

- Ctrl-O to save and Ctrl-X to exit

- Activating VirtualHost file:
```
sudo a2ensite govuk.conf
#output should be following:
Enabling site gci.
To activate the new configuration, you need to run:
  service apache2 reload

```
- Restart Apache by typing:
```
service apache2 reload
```
- Add hosts records to your client system hosts file ( i.e **Windows**: C:\Windows\System32\drivers\etc\hosts , **Linux, macOS and  Unix-like:** /etc/hosts ) as follows

```
<VM IP ADDRESS> gov.uk.local www.gov.uk.local
```
- Open `http://gov.uk.local` again and make sure we are in gov.uk welcome site

## Enable SSL to use https

- Steps above just only use for http and can not work with https , next step we will enable SSL to use https

- Generate a Certificate and private key using following command:
```
mkdir ~/certificates
cd ~/certificates
openssl req -x509 -newkey rsa:4096 -keyout apache.key -out apache.crt -days 365 -nodes
#Then fill the SSL parameters, CN(Common name) should be www.gov.uk
```
- move the certificate into the same folder you created using the following commands:
```
sudo mkdir /etc/apache2/ssl
sudo mv ~/certificates/* /etc/apache2/ssl/.
```
- Edit default Apache SSL site config directory using the following command:
```
sudo nano /etc/apache2/sites-available/default-ssl.conf
```
- This config file tells the server where to find SSL certificate. It should look like this:
```
<IfModule mod_ssl.c>
<VirtualHost _default_:443>
ServerAdmin webmaster@localhost

DocumentRoot /var/www/html

ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined

SSLEngine on

SSLCertificateFile    /etc/ssl/certs/ssl-cert-snakeoil.pem
SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
....
```
- Add this line below the ServerAdmin line:
```
ServerName gov.uk.local
```
- Change `DocumentRoot` point to 'govuk' directory:
```
DocumentRoot /var/www/govuk
```
- Edit these lines with our certificate location:
```
SSLCertificateFile    /etc/apache2/ssl/apache.crt
SSLCertificateKeyFile /etc/apache2/ssl/apache.key
```
- Our file should look like this:
```
<IfModule mod_ssl.c>
<VirtualHost _default_:443>
ServerAdmin webmaster@localhost
ServerName gov.uk.local
DocumentRoot /var/www/govuk

ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined

SSLEngine on
SSLCertificateFile    /etc/apache2/ssl/apache.crt
SSLCertificateKeyFile /etc/apache2/ssl/apache.key
```
- Ctrl-O to save and Ctrl-X to close file

- Enable the Apache SSL module:
```
sudo a2enmod ssl
```
- Enable the site we have just edited:
```
sudo a2ensite default-ssl.conf
```
- Restart Apache:
```
sudo service apache2 restart
```
- The website is now secure, access it using following address in the browser https://gov.uk.local

## Exporting OVA

* Shut down the machine 
* Open the controller machine (Or from your local machine, just the controller machine speed the things up)
* Run the following command to export the VM with OVA extension (change to corresponding ESXI IP/URL and VM name), it will be exported in your current working directory.

Note: the username and password to be provided here are the initial ESXI server credentials  

```bash
ovftool vi://46.165.225.145/glasswall-wordpress ./glasswall-wordpress.ova
```

## Importing OVA and setting wordpress site

- Download OVA file from [here](https://glasswall-sow-ova.s3.amazonaws.com/vms/wordpress/Glasswall-wordpress.ova?AWSAccessKeyId=AKIA3NUU5XSYVTP3BV6R&Signature=QwJ78so5inpe%2F4iVG8sqUTB5%2B0Q%3D&Expires=1607568331)

- Open VirtualBox/VMware workstation and import downloaded OVA file: glasswall-wordpress.ova

- Start Glasswall wordpress VM
​
- Login (username: **glasswall**, password: **glasswall**)

- By default, Glasswall wordpress VM is web server and use static IP. Network mode is Brigde 
​​​
- Get ethernets interface
```
$ ip a
# get the network interface name for example ens160
```
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
- Change ethernets interface `ens33` by your network interface above

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
- Add hosts records to your client system hosts file ( i.e **Windows**: C:\Windows\System32\drivers\etc\hosts , **Linux, macOS and  Unix-like:** /etc/hosts ) as follows

```
<VM IP ADDRESS> gov.uk.local www.gov.uk.local
```
- Open `http://gov.uk.local` again and make sure we are in gov.uk welcome site
  

