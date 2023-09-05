# Example ArgoCD application definitions for ClickHouse analytic applications

In this project you'll find ArgoCD applications and instructions to stand up 
a full analytic stack based on ClickHouse in a Kubernetes cluster. 

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

ArgoCD default password can be retrieved from k8s secrets
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
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

Run `delete-stack-apps.sh` followed by `delete-stack-deps.sh` in the
apps directory. 

You must clean up the apps before removing dependencies. The Altinity 
operator must be present to delete ClickHouse clusters. If you forget, 
deletion of ClickHouse resources may hang. If that happens, take the 
following steps to clean up fully. 

1. Run 'kubectl edit' on any chi resource and remove the finalizer. 
2. Drop the namespace. 
