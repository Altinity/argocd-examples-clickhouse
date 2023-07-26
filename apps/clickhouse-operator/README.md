# ClickHouse

Installs Altinity ClickHouse Operator from helm chart.

## Configuration

None. 

## Installation

Sample installation is shown below. 

```
argocd app create clickhouse-operator \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/clickhouse-operator \
 --dest-server https://kubernetes.default.svc --dest-namespace ch
argocd app sync clickhouse-operator
```

## Additional notes

None. 

## Acknowledgements and Further Information

[Altinity Kubernetes Operator for ClickHouse GitHub Project](https://github.com/Altinity/clickhouse-operator)

