Title: Kubernetes objects and specification

A K8s object is a "record of intent" which tells K8 how you want the cluster to look like - aka, desired state. You can create and manage these objects by using the **Kubernetes API**. You typically do so by using the `kubectl` CLI tool Every K8 object has two fields `spec` (specification of desired state) and `status` (current status that k8 system will update by the control plane). The k8 system will work actively to bring the `status` to match the `spec`, the desired state.

## K8s Object spec

Below is an example of a Kubernetes deployment in Yaml specification:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx

  replicas: 2 # tells deployment to run 2 pods matching the template
  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```

You will typically pass this to `kubectl` as shown below to create a deployment:

```
kubectl apply -f <path to yaml file>
```
The following fields are compulsory

- `apiVersion`: corresponds to K8s version
- `kind`: what type of object is this spec for
- `metadata`: unique identifiers for the object - `name`, `UID`, `namespace`
- `spec`: the state specification

The spec is different for each type of object and can have nested objects. The [K8s API ref](https://kubernetes.io/docs/reference/kubernetes-api/) contains templates that can be used for different object types