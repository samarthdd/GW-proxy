# Upwork Project briefs

See [How we use Upwork at Glasswall](https://www.slideshare.net/LukeRobbertse/how-we-use-upwork-at-glasswall) for more context about how Glasswall has embraced Upwork to find and hire talent. 

## Rules of engagement
  
 - All work done for the projects defined below are to be released under the Apache 2.0 Open Source license
 - All work and conversation threads to be public (on GitHub or Slack)
    - There is no direct (i.e. private) support. 
    - Part of the exercise is to see how Upwork resources are able to: 
      - a) work independently and 
      - b) collaborate effectively (namely with other Upwork resources)
 - These projects are used to evaluate new Upwork resources 
 - At times, there will be multiple Upwork resources working on the same tasks
 - Each Upwork resource is allocated (via the Upwork UI) a number of hours to work on these projects (which represents the maximum that Glasswall will pay for the work done)
 - Tech Stack
    - Python and Javascript (node) for backend code
    - React for frontend code
    - Jupyter Notebooks
    - AWS lambda or Azure Serverless functions
    - Git
    - GitHub Actions
    - Markdown
    


### Project #1) Data analysis and visualization

**Objective**: Consume, process, normalize and visualize GitHub Issues data

- Glasswall ICAP project (see https://github.com/filetrust/program-icap) is currently under active development and there is a need to understand the exact issue status of all sub-projects
- There are a number of sub-projects (each with it's own set of issues)
  - https://github.com/filetrust/mvp-icap-service
  - https://github.com/filetrust/mvp-icap-cloud
  - https://github.com/filetrust/rebuild-k8s-filetypedetection
  - https://github.com/filetrust/rebuild-k8s
- At the moment we are using https://www.zenhub.com/extension to consolidate and understand the data, but there are a number of workflows that require the creation of data-connectors and custom visualizations
- Here is the recommended workflow for this project:
  - create API (Python or Node) to consume data from GitHub (all repos are public, so there is no dependency on Glasswall to provide access)
  - write Tests for all APIs created
  - create CI Pipeline 
  - use Jupyter notebook to present data 
  - create visualizations using Javascript visualization APIs
  - transform data into graph-based objects and visualize them
  - create as much detailed technical documentation as possible (namely architecture and data-flow diagrams)
- That said, we encourage innovation and creative thinking, so please fell free to show alternative technologies, workflows and visualizations
 


