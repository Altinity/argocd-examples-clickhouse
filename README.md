# Example ArgoCD application definitions for ClickHouse analytic applications

In this project you'll find ArgoCD applications and instructions to stand up 
a full analytic stack based on ClickHouse in a Kubernetes cluster. 

## Prerequisites

You'll need a Kubernetes cluster. EKS, GKE, or minikube should all be OK. 

Install the following tools in your environment. ArgoCD should be installed
in the argocd namespace. 
You can use the script
```
./install-argocd.sh
```

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
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

You can also use the script.
```
./login-argocd.sh
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

### Grafana (Manual steps)
The admin password can be reset by executing the following command on the grafana pod.
```
grafana-cli admin reset-admin-password admin
```

The `admin` password is stored in `grafana-admin-credentials` secret.
```
kubectl get secret grafana-admin-credentials --template={{.data.GF_SECURITY_ADMIN_PASSWORD}} -n ch|base64 -d
```

Open the grafana UI by setting up port-forward on the grafana pod.
```
kubectl port-forward -n ch svc/grafana-service 3000:3000
```
Login as admin and the password retrieved in the previous step.

### Prometheus Operator
ArgoCD has a bug where the prometheus operator CRD cannot be installed
because of the `CRD too long` error.
This is a known issue with ArgoCD. See
https://github.com/prometheus-community/helm-charts/issues/2479
To work around this, stripped down CRDs are used.
`make stripped-down-crd` will generate the stripped down CRDs in prometheus operator.


## ArgoCD SyncWaves
App of Apps pattern
https://codefresh.io/blog/argo-cd-application-dependencies/
https://redhat-scholars.github.io/argocd-tutorial/argocd-tutorial/04-syncwaves-hooks.html

## ToDO (Use sops to encrypt passwords)
https://cloud.redhat.com/blog/a-guide-to-gitops-and-secret-management-with-argocd-operator-and-sops