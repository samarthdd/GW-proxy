# Monitoring OVA

Table of Contents
=================

   * [Monitoring OVA](#monitoring-ova)
   * [Table of Contents](#table-of-contents)
      * [Diagram](#diagram)
      * [Image](#image)
      * [Install OS](#install-os)
      * [Install Elasticsearch](#install-elasticsearch)
      * [Install Kibana](#install-kibana)
      * [Log Aggregator](#log-aggregator)
         * [Fluentd on each VM](#fluentd-on-each-vm)
         * [Update Configuration](#update-configuration)
      * [Kubernetes logging](#kubernetes-logging)
         * [Create necessary resources](#create-necessary-resources)
         * [Download daemon set manifest](#download-daemon-set-manifest)
         * [Update elasticsearch endpoint](#update-elasticsearch-endpoint)
         * [Deploy fluentbit daemonset](#deploy-fluentbit-daemonset)
      * [Credentials](#credentials)
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
	echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
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
	apt-get install -y td-agent-bit
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

## Kubernetes logging
### Create necessary resources
```
{
	kubectl create namespace logging
	kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-service-account.yaml
	kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role.yaml
	kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-binding.yaml
	kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/output/elasticsearch/fluent-bit-configmap.yaml
}
```
### Download daemon set manifest
```
wget https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/output/elasticsearch/fluent-bit-ds.yaml
```
### Update elasticsearch endpoint
```
        - name: FLUENT_ELASTICSEARCH_HOST
          value: "78.159.113.37"
        - name: FLUENT_ELASTICSEARCH_PORT
          value: "9200"
```
### Deploy fluentbit daemonset
```
kubectl create -f fluent-bit-ds.yaml
```
## 
## Credentials
Username: ubuntu
Password: ubuntu123
