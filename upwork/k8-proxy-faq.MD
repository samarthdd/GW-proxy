# Operational FAQ

 The FAQ is to help you get things done quickly for day to day work inside your projects. 
  
 ## Infrastructure ( AWS , Google Cloud, Docker image)

In  #ops-permission-access  channel request Petra and Alona Reyes for AMI . when you have the IAM with EC2 permission, you can create the AMI yourself. 
Name : 
Email ID : 
List of permissions : E.g. EC2, S3, Serverless, EKS
Also As given [here](https://www.packer.io/docs/builders/amazon#iam-task-or-instance-role)  
**Security** 

 - Port : Any EC2 instances launched should not have any open ports unless necessary, if ports are open there should be a conditional access enabled for a specific IP address only through that port, no publicly facing IP address.
 - security tag: It should have a security tag

    Owner: Your name 
    Team : K8
    Scope: Your Project name.

Any instances found that do not fulfil this criteria will be deleted for security reasons, security audits will be performed daily. This is in compliance with GW Security Policies.
Any hacking event that occurs due to not complying with this will have an incident raised as consequence
