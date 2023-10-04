# ClickHouse Keeper

Installs ClickHouse Keeper as a stateful set from a manifest. 

## Configuration

None. 

## Installation

Sample installation is shown below. 

```
argocd app create clickhouse-keeper \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/clickhouse-keeper \
 --dest-server https://kubernetes.default.svc --dest-namespace ch
argocd app sync clickhouse-keeper 
```

## Additional notes

The manifest is based on an [example single-node ClickHouse Keeper
deployment](https://github.com/Altinity/clickhouse-operator/blob/master/deploy/clickhouse-keeper/clickhouse-keeper-1-node.yaml)
provided by the Altinity K8s operater. Production deployments should
have 3 nodes.

## Acknowledgements and Further Information

[Altinity Kubernetes Operator for ClickHouse GitHub Project](https://github.com/Altinity/clickhouse-operator)
