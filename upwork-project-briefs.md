# Upwork Project briefs

See [How we use Upwork at Glasswall](https://www.slideshare.net/LukeRobbertse/how-we-use-upwork-at-glasswall) for more context about how Glasswall has embraced Upwork to find and hire talent. 

### Project #1) Data analysis and visualization

**Objective**: Consume, process, normalize and visualize GitHub Issues data

- Glasswall ICAP project (see https://github.com/filetrust/program-icap) is currently under active development and there is a need to understand the exact issue status of all sub-projects
- There are a number of sub-projects (each with it's own set of issues)
  - https://github.com/filetrust/mvp-icap-service
  - https://github.com/filetrust/mvp-icap-cloud
  - https://github.com/filetrust/mvp-icap-squid-cache-proxy
  - https://github.com/filetrust/rebuild-k8s-filetypedetection
  - https://github.com/filetrust/icap-performance-tests
  - https://github.com/filetrust/rebuild-k8s
  - https://github.com/filetrust/k8-reverse-proxy
- At the moment we are using https://www.zenhub.com/extension to consolidate and understand the data, but there are a number of workflows that require the creation of data-connectors and custom visualizations
- Here is the recommended workflow for this project:
  - create API (Python or Node) to consume data from GitHub (all repos are public, so there is no dependency on Glasswall to provide access)
  - write Tests for all APIs created
  - create CI Pipeline 
  - use Jupyter notebook to present data 
  - create visualizations using native Jupyter APIs or other Javascript visualization APIs (like https://visjs.org/, https://plantuml.com/ , https://gojs.net/ , https://mermaid-js.github.io/)
  - transform data into graph-based objects and visualize them
  - create as much detailed technical documentation as possible (namely architecture and data-flow diagrams)
 

### Project #2) K8 Traffic Generator

**Objective**: Create a Kubernetes (K8) native application that is able to generate large amounts of web traffic (namely file downloads)

- In order to effectively test the [Glasswall ICAP project](https://github.com/filetrust/program-icap) we need a test framework that is able to simulate user traffic like:
  - Open pages
  - Follow links
  - Upload files
  - Download files
- Key concept is to use each K8 pod as an 'user', which depending on some configurable values, will perform a number of pre-determined or random actions
- Key objective is to be able to use this K8 solution to scale up and down the traffic (which should simply be a case of adding or removing pods from the cluster)
  - key milestone is to be able to find the limitations of a particular ICAP deployment
- CI and CD pipeline are a key requirement (with the entire test scenario being able to be executed from scratch)
- Target execution environments for the k8 environment:
 - locally (using Docker Desktop)
 - EC2 or Azure VM (with K8 installed)
 - Managed EKS (AWS or Azure)
- implement logging solutions to visualize what is going on inside the K8 environnement (with a special focus on the individual pods actions and the server's responses)

### Project #3) K8 Glasswall Rebuild



### Project #4) Glasswall Reverse Proxy use-cases

**Objective**: Use Reverse Proxy to protect specific websites using the Glasswall Rebuild Engine

- Glasswall Rebuild engine creates safe files using [CDR technology](https://glasswallsolutions.com/technology/). We have and SDK and Cloud-Native API solution that allows customers/OEMs to use CDR in their products. The problem is that this requires heavy integrations and code changes by our customers on their applications/appliances
- the key objective for this project is to use a Reverse Proxy that is placed between the user and the target website, use that Proxy to intercept the files and use the Glasswall ICAP solution to rebuild the file safely
- there are two key milestones for this project:
  - 1) reverse proxy the target website (with website working with no side-effects)
  - 2) use proxy's ICAP to send files to externally hosted Glasswall ICAP Server  (i.e. the ICAP Server is not part of this project) 
- First batch of reserve proxies to use (we will need a reference implementation for each one):
  - Squid Proxy (http://www.squid-cache.org/) - hosted on docker
  - ProxyEG (https://www.proxyeg.com/squidva/) - hosted on docker
  - F5 (we have an VM Appliance that can be used)
- Target execution environments:
 - locally (using Docker Desktop)
 - EC2 or Azure VM 
- Target websites to proxy and protect (fell free to propose more) :
  - https://glasswallsolutions.com
  - https://engineering.glasswallsolutions.com
  - https://file-drop.co.uk
  - https://www.vmray.com
  - https://gohire.io
  - https://gofile.io
  - https://www.upwork.com/
- Each website will need its own separate deployment environment 
- Note that some of the websites should work with no modification of request/response http traffic , but some sites (like gofile.io) will require real-time changes (in the gofile.io example, the rewrite of the url returned by an API call with the location of the file to download)
- creation of an CI and CD pipeline to build, configure and deploy each solution 
- Implement logging solutions to visualize what is going on the proxy

- Project Repository:
- https://github.com/filetrust/k8-reverse-proxy

### Project #5) Technical Documentation

**Objective**: 


### Project #6) CDR Security Community 

**Objective**: Find and engage with security engineers and developers who are doing CDR related research

- for example:
  - https://redteamer.tips/introducing-gg-aesy-a-stegocryptor/
  - 
- other tasks:
 - editor for out medium blog


### Project #7) Slack Bot Developer (based on Python AWS Serverless functions)
 
### Project #8) XML analysis of Glasswall Rebuild 
- visualise it
- create threat intelligence reports

### Project #9) Project management
