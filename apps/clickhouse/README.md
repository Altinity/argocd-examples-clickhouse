# ClickHouse

Installs ClickHouse from a ClickHouseInstallation (CHI) manifest.

## Configuration

None. 

## Installation

Sample installation is shown below. 

```
argocd app create clickhouse \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/clickhouse \
 --dest-server https://kubernetes.default.svc --dest-namespace ch
argocd app sync clickhouse 
```

Once ClickHouse is running you may login with user/password 
root/secretsecret.

## Additional notes

Depends on the following applications: 
* clickhouse-operator - Altinity Kubernetes Operator for ClickHouse (aka "ClickHouse operator")
* zookeeper - Required to operate a cluster

## Acknowledgements and Further Information

[Altinity Kubernetes Operator for ClickHouse GitHub Project](https://github.com/Altinity/clickhouse-operator)
