# Project K8 Glasswall Rebuild

For Upwork resources, please read the [Rules of Engagement](../rules-of-engagement.md)


### Project Brief

**Objective**: Create a Kubernetes (K8) native application that is able to process 1000s of files using the Glasswall Rebuild engine

- Glasswall Rebuild is a CDR (Content Disarm and Reconstruction) tool that creates safe files by rebuilding the original file into a new file in 'known good' state (for example without Macros, Javascript or Metadata)
- Due to the fact that this engine is designed to receive potentially malicious files, the security of the execution environment is super important.   
    - In practice this means that we want to execute each file rebuild in a pristine (i.e. new) docker container
    - in K8 this means that we need 1 pod per file to be processed
- Here are the key workflows required for this project:
    - Folder exists with 100 or 1000s of files to be processed
    - K8 environments boots up and starts processing the files 
    - One pod and one container is used for each file (note that there could be other supporting containers in that pod, but only one should be using the Glasswall engine to process the target file)
    - one rebuild is complete, the engine output (rebuilt file and xml report) are stored in a separate folder, and pod is destroyed
- use CI and CD pipeline has a way to trigger workflow
- Target execution environments for the K8 environment:
    - locally (using Docker Desktop)
    - EC2 or Azure VM (with K8 installed)
    - Managed EKS (AWS or Azure)
- Implement logging solutions to visualize what is going on inside the K8 environnement

### Comms

Slack channel: https://glasswallsolu-qbp1117.slack.com/archives/C0199AQH0QK

### References

For more details about how the Glasswall Engine works, please see:

- https://github.com/filetrust/Glasswall-Rebuild-SDK-Evaluation : here you will find the engine and docker builds
- https://github.com/filetrust/Glasswall-Rebuild-SDK-Evaluation/blob/master/Getting-Started/Getting-Started.md : here are instructions for getting it running on docker
- https://engineering.glasswallsolutions.com/docs/product-descriptions/product-overview
