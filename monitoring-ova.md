# Monitoring OVA
https://glasswall-sow-ova.s3.amazonaws.com/vms/visualog/visualog.ova?AWSAccessKeyId=AKIA3NUU5XSYVTP3BV6R&Signature=B3p%2FTRsLKyl6Pij6JoKvI4g10cw%3D&Expires=1607669097

## Install OS
- Download Ubuntu 20.04 Live Server ISO file
- Load VMWare VM CDROM drive with ISO file
- Boot the VM
- Follow the instruction during installation wizard

## Install Elasticsearch
```
{
	wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
	sudo apt-get install apt-transport-https
	sudo apt-get update && sudo apt-get install elasticsearch
	sudo /bin/systemctl daemon-reload
	sudo /bin/systemctl enable elasticsearch.service
	sudo systemctl start elasticsearch.service
}
```

## Install Kibana
```
{
	wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
	sudo apt-get install apt-transport-https
	sudo apt-get update && sudo apt-get install kibana
	sudo /bin/systemctl daemon-reload
	sudo /bin/systemctl enable kibana.service
	sudo systemctl start kibana.service
}
```
