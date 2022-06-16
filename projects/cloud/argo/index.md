Title: Argo workflows for Kubernetes

## What is Argo?
Argo helps make Kubernetes more accessible to everyone. It provides services for creating workflows and jobs that build on Kubernetes. Argo is composed of the following services:

- **Argo Workflows** - orchestrate parallel jobs on K8. Represent workflows as DAGs and easily run compute intensive jobs.
- **Argo CD** - uses git repo as the source of truth and builds the deployment env to conform to the repo. Config is via a `YAML` file or `Helm` package.
- **Argo Events** - dependency manager that is events based. It can hook up and listen to sources like AWS SNS, SQS, GCP PubSub and execute workflows.


## Why Argo?
Argo is a compelling solution for those that already build on K8. Argo does not reinvent K8 features, instead builds on them. It enables implementing each step in the workflow as a container. It provides artifact management that allows to specify the output from any step as input to another. Since everything is as containers, the entire workflow, including each step and their interactions can be managed as source code (in YAML). This is called **container native workflow management**. Thus a workflow that runs on one Argo env will run exactly the same on another, allowing for better portability.

## Argo CLI commands

**[List workflows](https://argoproj.github.io/argo-workflows/cli/argo_list/)**
```
$ argo list -n <namespace> <flags>
$ argo list -n flood --running  # will list all running workflows in the flood namespace
$ argo list -n flood --completed  # for completed wf
```
example output:

```
NAME                                               STATUS                AGE   DURATION   PRIORITY
ingest-weather-data-compass-lisflood-japan-xb7pm   Running               4m    4m         0
flood-pipeline-ps8rf                               Running               42m   41m        0
jp-3hr-live-cgtrb                                  Running               44m   44m        0
jp-3hr-hist-lc89r                                  Running               2d    2d         0
```


## Resources
- [Medium.com: What is Argo and how it works on GKE](https://mohamed-dhaoui.medium.com/what-is-argo-and-how-it-works-in-google-kubernetes-engine-d8c2e55e8fbe)
- [Argo blog: Introductory article](https://blog.argoproj.io/introducing-argo-a-container-native-workflow-engine-for-kubernetes-55c0b4b76fac).
- Argo version on Dev cloud: 3.3.6
