# ClickHouse Operator

Installs Altinity ClickHouse Operator from helm chart.

## Configuration

None. 

## Installation

Sample installation is shown below. 

```
argocd app create clickhouse-operator \
 --repo https://github.com/rahularram1999/argocd-examples-clickhouse.git.git \
 --path apps/clickhouse-operator \
 --dest-server https://kubernetes.default.svc --dest-namespace clickhouse
argocd app sync clickhouse-operator
```

## Additional notes

None. 

## Acknowledgements and Further Information

[Altinity Kubernetes Operator for ClickHouse GitHub Project](https://github.com/Altinity/clickhouse-operator)
