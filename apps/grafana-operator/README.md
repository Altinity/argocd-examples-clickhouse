# Grafana Operator

Installs Grafana Agent Operator from a helm chart.

## Configuration

None. 

## Installation

Sample installation is shown below. 

```
argocd app create grafana-operator \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/grafana-agent-operator \
 --dest-server https://kubernetes.default.svc --dest-namespace ch
argocd app sync grafana-operator
```

## Additional notes

None. 

## Acknowledgements and Further Information

[GrafanaLabs operator installation procedure](https://grafana.com/docs/agent/latest/operator/helm-getting-started/)

