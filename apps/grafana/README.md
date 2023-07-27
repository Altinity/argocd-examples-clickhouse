# Grafana

Installs Grafana as a deployment from a manifest. 

## Configuration

None. 

## Installation

Sample installation is shown below. 

```
argocd app create grafana \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/grafana \
 --dest-server https://kubernetes.default.svc --dest-namespace ch
argocd app sync grafana 
kubectl port-forward svc/grafana -n ch 3000:3000
```

Once the grafana server is available you may login using user/password
admin/admin. 

## Additional notes

If you are accessing K8s via a bastion host, you can forward back to
your laptop as follows.

```
ssh  -L 3000:localhost:3000 bastion-host
```

## Additional notes

The manifest is based on an [example Grafana deployment](https://github.com/Altinity/clickhouse-operator/blob/master/deploy/grafana/grafana-manually/grafana.yaml)
provided by the Altinity K8s operater. 

## Acknowledgements and Further Information

[Altinity Kubernetes Operator for ClickHouse GitHub Project](https://github.com/Altinity/clickhouse-operator)
