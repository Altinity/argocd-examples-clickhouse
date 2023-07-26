# Example ArgoCD application definitions for ClickHouse analytic applications. 

## Prerequisites

You'll need a Kubernetes cluster. EKS, GKE, or minikube should all be OK. 

Install the following tools in your environment. ArgoCD should be installed
in the argocd namespace. 

* [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
* [argocd](https://argo-cd.readthedocs.io/en/stable/getting_started/)
* [kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/)

Confirm that you can connect to Kubernetes by listing available namespaces.
```
kubectl get ns
```

## Login to ArgoCD

All commands with argocd require an accessible ArgoCD API endpoint and a
valid token. Get them as follows.
```
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
argocd login localhost:8080 --username=admin --password="yourpassword" --insecure
```

## Bring up the analytic stack

Run the `create-stack.sh` script in the apps directory.

## Make endpoints accessible

Run the `forward-stack.sh` script in the apps directory.

## Remove the analytic stack

Run the `delete-stack.sh` script in the apps directory.
