title: Kubectl commands

## Commands

**Get nodes `k get nodes`**

```
(local2) ➜  Documents k get nodes
NAME       STATUS   ROLES           AGE     VERSION
minikube   Ready    control-plane   7d22h   v1.24.1
```

**Get namespaces `k get ns`**

```
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