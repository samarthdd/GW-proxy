# Production websites 

The following websites have ICAP proxy implementation in production. 


| Website  | URL | IP | Flavor | Ports opened | Status | Repo |
|---|---|---|---|---|---|---|
| GW Engineering  | https://engineering.glasswallsolutions.com.glasswall-icap.com | 54.170.84.172 | B: Docker v0.1  |  443 | Live in testing |[GW engineering](https://github.com/k8-proxy/gp-engineering-website)|
| gov.uk          | https://gov.uk.glasswall-icap.com | 51.11.8.179 |A: K8s v0.1||in Development|[Gov UK](https://github.com/k8-proxy/gp-gov-uk-website)|
| Xamarines sharepoint      |||A: K8s v0.1||in Development|[Xamarines sharepoint](https://github.com/k8-proxy/gp-sharepoint/issues)|
| Internal sharepoint      |||||in Development||
| GW Website      | https://glasswallsolutions.com.glasswall-icap.com             | 54.78.209.23  |A: K8s v0.1      | 443  | Live in testing |[Glasswall Solutions](https://github.com/k8-proxy/gp-glasswallsolutions-website)|
| dataport.emma.msrb.org |https://dataport.emma.msrb.org.glasswall-icap.com/Home/Index||E: SOW v0.2||Live in Testing|[Emma port](https://github.com/k8-proxy/gp-emma-dataport-website)|
| File drop | https://glasswall-file-drop.com.glasswall-icap.com | 18.221.160.41 |A: K8s v0.1||in Development|[File drop](https://github.com/k8-proxy/gp-filedrop-website)|
| Atlasian |||SOW v0.2||in Development|[JIRA](https://github.com/k8-proxy/gp-jira-website)|
| owasp.org |||SOW v0.2||in Development|[OWASP](https://github.com/k8-proxy/gp-owasp-website)|
| GitHub.com |||SOW v0.2||in Development| [GitHub](https://github.com/k8-proxy/gp-github)|
| Microsoft.com |||SOW v0.2||in Development|
| UK Zones  | https://uk.zones.com.glasswall-icap.com | 54.78.104.24 |B: Docker v0.1| 443 | Live in testing |[UK zones](https://github.com/k8-proxy/gp-uk-zones-com)|



Other dns mappings:

- gw-demo-sample-files-eu1.s3-eu-west-1.amazonaws.com.glasswall-icap.com : 54.170.84.172
- www.glasswallsolutions.com.glasswall-icap.com : 54.78.209.23
- *.gov.uk.glasswall-icap.com , assets.publishing.service.gov.uk.glasswall-icap.com , www.gov.uk.glasswall-icap.com : 51.11.8.179



# Open-Source

This repo contains information about a number of Open Source process that Glasswall is currently developing

### Upwork K8 Projects

Here are the Open Source projects we are funding via Upwork:

| Project  | PM | Type  |
|---|---|---|
|[K8 Glasswall Rebuild](upwork/project-k8-glasswall-rebuild) |Mark Bandillo  | Pioneer  |
|[k8-traffic-generator](https://github.com/filetrust/k8-traffic-generator)   |Faisal Adnan, Mark Bandillo   |Pioneer   |
|[k8-data-visualization](https://github.com/filetrust/k8-data-visualization)   |Chris Diao, Susil Parida   |Pioneer   |
|[k8-reverse-proxy](https://github.com/filetrust/k8-reverse-proxy)   |Mahmoud Nouman  |Pioneer   |
|[k6-performance-use-cases](https://github.com/filetrust/k8-performance-use-cases)  |Faisal Adnan   |Pioneer   |
|[k8-test-data](https://github.com/filetrust/k8-test-data)  |Susil Parida   |Pioneer   |
|[rebuild-k8s-filetypedetection](https://github.com/filetrust/rebuild-k8s-filetypedetection)  | 
|[Threat-intelligence-reporting](https://github.com/filetrust/threat-intelligence-reporting)  |Georgina Gonzalez, Jonathan Canales|Pioneer |
|[k8-ova](https://github.com/filetrust/k8-ova)  |Georgina Gonzalez |Settlers |
|[k8-slack-bot](https://github.com/filetrust/k8-slack-bot)  |Jonathan Canales   |Pioneer   |
|[k8-electron-react](https://github.com/filetrust/k8-electron-react)  |Jonathan Canales,Virendra Vaishnav | Pioneer  |
|k8-business-stakeholders | NA | General |
|s-k8-buildpipeline |Georgina Gonzalez  |Settlers  |
|s-k8-core | NA  |Settlers  |
|k8-wardley-maps | TBD  | Pioneer |
|[p-k8-security](https://github.com/filetrust/k8-security)| Jonathan Canales  | Pioneer |


###  Upwork support projects

The following projects support the K8 project's needs:

| Project  | PM | Type  |
|---|---|---|
|demo-reverse-proxy-cornerstoneondemand |Georgina Gonzalez  | Demo |
|demo-reverse-proxy-gov-uk |Mahmoud Nouman |Demo  |
|t-gov-uk-prod |Georgina Gonzalez  |Town Planners |
|marketing | TBD |Support|
|project management |NA  |General  |
|aws-resources |NA  | Support |
|guild-devs | TBD  | Support |
|guild-elasticsearch | TBD  | Support |
|p-chrome-extension | Virendra Vaishnav | Support |
|p-design-requests | Shashank Saksena | Support |
|p-ui-wireframes |AbdelRahman Khaled  |Support  |
|technical-documentation |  |Support  |
|technical-resources |Andres Jimenez  |Support  |
|welcome |Doviana Tollaku  |Support  |
