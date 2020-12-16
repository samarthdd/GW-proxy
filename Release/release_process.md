## Release Process Flow Diagram

The main goals taken into consideration in the flow diagram are:

- setting requirements and planning tasks for the week on **Fridays**
- development ends on **Wednesdays**
- testing starts on **Thursdays** and ends on **Fridays**
- deployments are ready by **Mondays**

![release_process_v1](img/ReleaseFlow.png)

## Initial release_info.yaml 

### Template
```
<OVA_NAME>:
  virtual_machine_type:
    server:
      - HAProxy-ICAP
      - ICAP-server
      - Shared Storage
      - Traffic Generator
      - Support
      - Proxy
      - Monitoring
    client:
      - ICAP-Client
      - Linux-Desktop
    website:
      - Minio-server
      - Wordpress
      - File-drop
      - gov.uk
      - HAProxy-web
  usage:
  description:
  release_date: mm/dd/yyyy
  version: 1.0.0
  dependencies:
    in_VM: # add dependencies within the VM
    other_VM: # add dependencies between VMs (i.e. another VM is required for certain VMs to work)
  fixes:
  new_features:
  ova_size:

```

### Example

```
SOW_REST_OVA:
  virtual_machine_type:
    - website
  usage: Proxied file-drop.com website
  description: Deploys file-drop.com on isolated VM
  release_date: 12/15/2020
  version_number: 1.0.0
  dependencies:
    in_VM:
      [curl, git]
    other_VM:
      none
  fixes: stronger password
  new_features: automatic network change
  ova_size: 1.8 GB
```