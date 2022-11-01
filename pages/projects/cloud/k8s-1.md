title: Kubectl commands

`kubectl` is the CLI tool that interfaces with Kubernetes. It can work with either a local setup (such as with Docker desktop's K8 or [Minikube](https://minikube.sigs.k8s.io/docs/)) or with one or more remote clusters. Most operations on K8s will be via `kubectl`.

## 1.`minikube` Commands
First, we need to start the local cluster. For that, we need to install [minikube](https://minikube.sigs.k8s.io/docs/).

### Install `minikube`
`brew` makes install easier, whether or not you are on a M1 mac. Run:

```
brew install minikube
```
followed by:
```
which minikube
minikube version
```

### Starting and stopping the local cluster
Minikube uses virtualbox to isolate the local set up of kubernetes. Once installed, you can run 
```
minikube start
```
which returns the following in my case:
```
$ minikube start
😄  minikube v1.27.1 on Darwin 12.6 (arm64)
🆕  Kubernetes 1.25.2 is now available. If you would like to upgrade, specify: --kubernetes-version=v1.25.2
✨  Using the docker driver based on existing profile
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
🔄  Restarting existing docker container for "minikube" ...
🐳  Preparing Kubernetes v1.24.1 on Docker 20.10.17 ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
    ▪ Using image docker.io/kubernetesui/metrics-scraper:v1.0.8
    ▪ Using image docker.io/kubernetesui/dashboard:v2.7.0
🌟  Enabled addons: default-storageclass, storage-provisioner, dashboard
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```

> **Note**: When minikube starts, `kubectl` will automatically bind to minikube's kubectl by modifying the `kubectl` **context**. Thus, running `k get pods` will only return the ones running in minikube, not your remote cluster. To talk to a different cluster, use the `k config use-context <context_name>` command.

Once done, you can stop the cluster by running

```
minikube stop
```

### Setting up `shpod` namespace
The k8s course recommends using [`shpod`](https://slides.kubernetesmastery.com/#142) for a consistent shell experience. The yaml file in the link has the definition of a namespace.

```
k apply -f https://k8smastery.com/shpod.yaml
k attach -n shpod -it shpod
```
The attach command follows the syntax `kubectl attach -n <namespace> --interactive --tty <contianer_name>`

Once done, the pod can be terminated using
```
k delete -f https://k8smastery.com/shpod.yaml
```

## 2.`kubectl` Commands
The `kubectl` command needs to know which cluster to talk to and how to authenticate. This information is stored in the `~/.kube/config` file. The provisioner (which can be GKE or minikube) will also provide / edit this file. The file as the IP address of the k8s server and the TLS certs for auth.

**Get contexts**
First, you need to know which k8s cluster you are talking to. For this run: The `*` points to the active cluster. All `kubectl` commands apply to that cluster now.

```
k config get-contexts
CURRENT   NAME        CLUSTER    AUTHINFO   NAMESPACE
          gke_dev     gke_dev    gke_dev    default
          gke_prod    gke_prod   gke_prod   default
          gke_stage   gke_stage  gke_stage  default
*         minikube    minikube   minikube   default
```

**Change contexts**
When you want to talk to a different cluster, change the cluster using the syntax `k config use-context <contxtname>`

```bash
k config use-context gke_dev
```
The run `k config get-contexts` to confirm the switch.

**Get nodes `k get nodes`**
Nodes are the physical machines that run the Kubernetes cluster. 

```
(local2) ➜  Documents k get nodes
NAME       STATUS   ROLES           AGE     VERSION
minikube   Ready    control-plane   7d22h   v1.24.1
```

The `get` command is the most frequently used command. `get` can return output in a variety of formats:

```bash
k get nodes -o wide
NAME       STATUS   ROLES           AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
minikube   Ready    control-plane   97d   v1.24.1   192.168.49.2   <none>        Ubuntu 20.04.4 LTS   5.10.104-linuxkit   docker://20.10.17
```

You can get return in `json` format and pipe that to a CLI tool called `jq` which can parse and extract certain info like this:
```bash
 k get node -o json | jq ".items[] | {name:.metadata.name} + .status.capacity"
{
  "name": "minikube",
  "cpu": "5",
  "ephemeral-storage": "61255492Ki",
  "hugepages-1Gi": "0",
  "hugepages-2Mi": "0",
  "hugepages-32Mi": "0",
  "hugepages-64Ki": "0",
  "memory": "8039792Ki",
  "pods": "110"
}
```

**Describe node `k describe node <node_name>`**
If you want to delve into the details of how the node is configured and its health, you can run
`k describe node minikube`.


**Get namespaces `k get ns`**

```bash
(flood_ml_local2) ➜  Documents k get ns
NAME                   STATUS   AGE
default                Active   7d22h
kube-node-lease        Active   7d22h
kube-public            Active   7d22h
kube-system            Active   7d22h
kubernetes-dashboard   Active   7d22h
```

**Create a new namespace `k create ns <ns_name>`**

```
(base) ➜  Documents k create ns argo-local
namespace/argo-local created

# verify

(base) ➜  Documents k get ns             
NAME                   STATUS   AGE
argo-local             Active   4h54m
default                Active   8d
kube-node-lease        Active   8d
kube-public            Active   8d
kube-system            Active   8d
kubernetes-dashboard   Active   8d
(base) ➜  Documents 
```

**Create argo server on k8s**

```
(base) ➜  Documents k apply -n argo-local -f https://raw.githubusercontent.com/argoproj/argo/stable/manifests/quick-start-postgres.yaml
customresourcedefinition.apiextensions.k8s.io/clusterworkflowtemplates.argoproj.io created
customresourcedefinition.apiextensions.k8s.io/cronworkflows.argoproj.io created
....
```
Then forward the port to local machine:

```
(base) ➜  Documents k -n argo-local port-forward deployment/argo-server 2746:2746
Forwarding from 127.0.0.1:2746 -> 2746
Forwarding from [::1]:2746 -> 2746

```
Argo server UI is now accessible at https://localhost:2746. You may have to agree to security warnings before accessing this page.

**Get pods `k get pods -n <namespace>`**

```
(base) ➜  Documents k get pods -n argo-local
NAME                                   READY   STATUS    RESTARTS        AGE
argo-server-7fbf57bc87-f82wl           1/1     Running   3 (2m11s ago)   2m31s
minio-74474c548b-6hf48                 1/1     Running   0               2m31s
postgres-6b5944c545-tpnfb              1/1     Running   0               2m31s
workflow-controller-7d4bf4fd7d-x4qkk   1/1     Running   2 (2m9s ago)    2m31s
(base) ➜  Documents 

```

**Creating Argo workflow using `kubectl`**

```
(base) ➜  ~ k create -n argo-local -f Documents/code/temp/wf-hello-world.yaml 
workflow.argoproj.io/hello-world-p4wlj created
```