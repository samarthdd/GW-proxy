# Monitoring OVA
## Diagram
![Monitoring Diagram](images/monitoring-ova.png)
## Image
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

## Log Aggregator
### Fluentd on each VM
```
{
	sudo su -
	wget -qO - https://packages.fluentbit.io/fluentbit.key | sudo apt-key add -
	echo "deb https://packages.fluentbit.io/ubuntu/focal focal main" >>  /etc/apt/sources.list
	apt-get update
	apt-get install td-agent-bit
	service td-agent-bit start
}
```
### Update Configuration
- Rewrite file /etc/td-agent-bit/td-agent-bit.conf at the end of the file
```
[INPUT]
    name cpu
    tag  cpu.local

    # Read interval (sec) Default: 1
    interval_sec 1

[INPUT]
    name mem
    tag  mem.local

[OUTPUT]
    name es
    match *
    Host 78.159.113.37
    Port 9200

[FILTER]
    Name record_modifier
    Match *
    Record hostname ${HOSTNAME}
```
- Restart fluentbit agent.
```
sudo service td-agent-bit restart
```


## Credentials
Username: ubuntu
Password: ubuntu123
