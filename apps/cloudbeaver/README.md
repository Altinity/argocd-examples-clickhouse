# CloudBeaver

Installs CloudBeaver from a Kubernetes manifest. 

## Configuration

None. 

## Installation

Sample installation is shown below. Includes a port forward to allow 
UI access. 

```
argocd app create cloudbeaver \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/cloudbeaver \
 --dest-server https://kubernetes.default.svc --dest-namespace ch
argocd app sync cloudbeaver 
kubectl port-forward svc/cloudbeaver -n ch 8978:8978
```

Once the server is running you may configure the editor and provide 
a password for the default cbadmin account. 

## Additional notes

If you are accessing K8s via a bastion host, you can forward back to
your laptop as follows.

```
ssh  -L 8978:localhost:8978 bastion-host
```

## Acknowledgements and Further Information

[CloudBeaver GitHub Project](https://github.com/dbeaver/cloudbeaver)

