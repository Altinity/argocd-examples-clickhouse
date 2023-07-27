# Prometheus

This example application installs prometheus from a
helm chart located in the community repo located at
https://prometheus-community.github.io/helm-charts. 

## Configuration

Helm chart parameter settings are located in values.yaml. It contains
parameter settings for the prometheus helm chart, indicated by the
`prometheus:` property.  You can look up values in the GitHub repo. See
https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus/values.yaml
for more information.

## Installation

Sample installation is shown below. 

```
argocd app create prometheus \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/prometheus \
 --dest-server https://kubernetes.default.svc --dest-namespace ch
argocd app sync prometheus 
```

## Additional notes

None. 

## Acknowledgements and Further Information

[Prometheus Community Helm Charts GitHub Project](https://github.com/prometheus-community/helm-charts)

