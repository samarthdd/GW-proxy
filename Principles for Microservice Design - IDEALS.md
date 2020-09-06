# Principles for Microservice Design: Think IDEALS, Rather than SOLID

## Interface Segregation
  The original Interface Segregation Principle admonishes OO classes with "fat" interfaces. In other words, instead of a class interface with all possible methods clients might need, there should be separate interfaces catering to the specific needs of each type of client.

  The microservice architecture style is a specialization of the service-oriented architecture, wherein the design of interfaces (i.e., service contracts) has always been of utmost importance. Starting in the early 2000s, SOA literature would prescribe canonical models or canonical schemas, with which all service clients should comply. However, the way we approach service contract design has changed since the old days of SOA. In the era of microservices, there is often a multitude of client programs (frontends) to the same service logic. That is the main motivation to apply interface segregation to microservices.

### Realizing interface segregation for microservices
```
  The goal of interface segregation for microservices is that each type of frontend sees the service contract that best suits its needs. For example: a mobile native app wants to call endpoints that respond with a short JSON representation of the data; the same system has a web application that uses the full JSON representation; there’s also an old desktop application that calls the same service and requires a full representation but in XML. Different clients may also use different protocols. For example, external clients want to use HTTP to call a gRPC service.

  Instead of trying to impose the same service contract (using canonical models) on all types of service clients, we "segregate the interface" so that each type of client sees the service interface that it needs. How do we do that? A prominent alternative is to use an API gateway. It can do message format transformation, message structure transformation, protocol bridging, message routing, and much more. A popular alternative is the Backend for Frontends (BFF) pattern. In this case, we have an API gateway for each type of client -- we commonly say we have a different BFF for each client, as illustrated in this figure.
```

## Deployability (is on you)
  For virtually the entire history of software, the design effort has focused on design decisions related to how implementation units (modules) are organized and how runtime elements (components) interact. Architecture tactics, design patterns, and other design strategies have provided guidelines for organizing software elements in layers, avoiding excessive dependencies, assigning specific roles or concerns to certain types of components, and other design decisions in the "software" space. For microservice developers, there are critical design decisions that go beyond the software elements.

  As developers, we have long been aware of the importance of properly packaging and deploying software to an appropriate runtime topology. However, we have never paid so much attention to the deployment and runtime monitoring as today with microservices. The realm of technology and design decisions that here we’re calling "deployability" has become critical to the success of microservices. The main reason is the simple fact that microservices dramatically increase the number of deployment units.

  So, the letter D in IDEALS indicates to the microservice developer that they are also responsible for making sure the software and its new versions are readily available to its happy users. Altogether, deployability involves:
  * Configuring the runtime infrastructure, which includes containers, pods, clusters, persistence, security, and networking.
  * Scaling microservices in and out, or migrating them from one runtime environment to another.
  * Expediting the commit+build+test+deploy process.
  * Minimizing downtime for replacing the current version.
  * Synchronizing version changes of related software.
  * Monitoring the health of the microservices to quickly identify and remedy faults.

### Achieving good deployability
```
  Automation is the key to effective deployability. Automation involves wisely employing tools and technologies, and this is the space where we have continuously seen the most change since the advent of microservices. Therefore, microservice developers should be on the lookout for new directions in terms of tools and platforms, but always questioning the benefits and challenges of each new choice. (Important sources of information have been the ThoughtWorks Technology Radar and the Software Architecture and Design InfoQ Trends Report.)

  Here is a list of strategies and technologies that developers should consider in any microservice-based solution to improve deployability:
    * Containerization and container orchestration: a containerized microservice is much easier to replicate and deploy across platforms and cloud providers, and an orchestration platform provides shared resources and mechanisms for routing, scaling, replication, load-balancing, and more. Docker and Kubernetes are today’s de facto standards for containerization and container orchestration.

    * Service mesh: this kind of tool can be used for traffic monitoring, policy enforcement, authentication, RBAC, routing, circuit breaker, message transformation, among other things to help with the communication in a container orchestration platform. Popular service meshes include Istio, Linkerd, and Consul Connect.

    * API gateway: by intercepting calls to microservices, an API gateway product provides a rich set of features, including message transformation and protocol bridging, traffic monitoring, security controls, routing, cache, request throttling and API quota, and circuit breaking. Prominent players in this space include Ambassador, Kong, Apiman, WSO2 API Manager, Apigee, and Amazon API Gateway.

    * Serverless architecture: you can avoid much of the complexity and operational cost of container orchestration by deploying your services to a serverless platform, which follows the FaaS paradigm. AWS Lambda, Azure Functions, and Google Cloud Functions are examples of serverless platforms.

    * Monitoring tools: with microservices spread across your on-premises and cloud infrastructure, being able to predict, detect, and notify issues related to the health of the system is critical. There are several monitoring tools available, such as New Relic, CloudWatch, Datadog, Prometheus, and Grafana.

    * Log consolidation tools: microservices can easily increase the number of deployment units by an order of magnitude. We need tools to consolidate the log output from these components, with the ability to search, analyze, and generate alerts. Popular tools in this space are Fluentd, Graylog, Splunk, and ELK (Elasticsearch, Logstash, Kibana).

    * Tracing tools: these tools can be used to instrument your microservices, and then produce, collect, and visualize runtime tracing data that shows the calls across services. They help you to spot performance issues (and sometimes even help you to understand the architecture). Examples of tracing tools are Zipkin, Jaeger, and AWS X-Ray.

    * DevOps: microservices work better when devs and ops teams communicate and collaborate more closely, from infrastructure configuration to incident handling.

    * Blue-green deployment and canary releasing: these deployment strategies allow zero or near-zero downtime when releasing a new version of a microservice, with a quick switchback in case of problems.

    * Infrastructure as Code (IaC): this practice enables minimal human interaction in the build-deploy cycle, which becomes faster, less error-prone, and more auditable.

    * Continuous delivery: this is a required practice to shorten the commit-to-deploy interval yet keeping the quality of the solutions. Traditional CI/CD tools include Jenkins, GitLab CI/CD, Bamboo, GoCD, CircleCI, and Spinnaker. More recently, GitOps tools such as Weaveworks and Flux have been added to the landscape, combining CD and IaC.

    * Externalized configuration: this mechanism allows configuration properties to be stored outside the microservice deployment unit and easily managed.
```
