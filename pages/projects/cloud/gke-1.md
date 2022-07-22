Title: Google Kubernetes Engine - An introduction

Kubernetes is an open-source platform for managing containerized workloads and services. `K8` (as it is colloquially known) makes it easy to orchestrate different containers on different hosts, scale them as microservices, deploy rollouts or rollbacks etc.

## Terminology used with Kubernetes

- **Node** - a physical machine that runs containers (with on-prem set up). In a cloud set up, this could be a VM.
- **Cluster** - a set of such nodes together running an application. A cluster can have a group of nodes that run as 
**control plane** and the remaining running as nodes for containers.
- **Node pool** - designate subset of nodes within a cluster.
- **Pod** - a process running a container (with a wrapper around it). Pods are the **smallest unit of reference in K8**. Usually only one container runs in a pod. But you can package more than 1 container, especially if they have to communicate or share resources. A pod can provide a unique IP per pod and different ports for different containers running within it. To interact with a pod, you can use the `kubectl` command.
    - ![](/images/gcp-k8-arch.jpg)
    - To see the list of pods in your cluster, run `kubectl get pods`

The IP address of a pod can change over time, especially as pods are created and terminated over time. Thus if the front-end pods refer to back-end pods by IP, the application may break. This is why you wrap the relevant pods behind a **service** and give it a fixed IP. As you scale your app, any number of pods can share that IP of that service.

You can use `kubectl` commands to create pods, create load balancer, network etc. However, k8 allows you to **declaratively define** your architecture in a Yaml file, called a **deployment config** file.

## Google Kubernetes Engine
GKE is a managed K8 in the cloud. It is a bunch of compute engine instances that are bound together to form a cluster. This cluster can be created using web UI or `gcloud` CLI. When using GKE, Google provides a built-in load-balancer service. 