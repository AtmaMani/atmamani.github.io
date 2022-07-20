Title: Google Kubernetes Engine - An introduction

Kubernetes is an open-source platform for managing containerized workloads and services. `K8` (as it is colloquially known) makes it easy to orchestrate different containers on different hosts, scale them as microservices, deploy rollouts or rollbacks etc.

## Terminology used with Kubernetes

- **Node** - a physical machine that runs containers (with on-prem set up). In a cloud set up, this could be a VM.
- **Cluster** - a set of such nodes together running an application. A cluster can have a group of nodes that run as **control plane** and the remaining running as nodes for containers.
- **Pod** - a process running a container (with a wrapper around it). Pods are the smallest unit of reference in K8. Usually only one container runs in a pod. But you can package more than 1 container, especially if they have to communicate or share resources. A pod can provide a unique IP per pod and different ports for different containers running within it. To interact with a pod, you can use the `kubectl` command.
    - ![](/images/gcp-k8-arch.jpg)
    - To see the list of pods in your cluster, run `kubectl get pods`