# Grafana

Installs Grafana Operator from GitHub grafana-operator repo manifests using 
kustomize. 

## Configuration

None. 

## Installation

Sample installation is shown below. 

```
argocd app create grafana-operator \
 --repo https://github.com/rahularram1999/argocd-examples-clickhouse.git.git \
 --path apps/grafana-operator \
 --dest-server https://kubernetes.default.svc --dest-namespace clickhouse
argocd app sync grafana-operator
```

## Additional notes

The grafana-operator leverages the kustomize deployment in the
grafana-operator project.  The kustomize.yaml in this directory selects
the version to use.

The namespace clickhouse is hardwired in ns-patch.yaml. 

## Acknowledgements and Further Information

[grafana-operator GitHub Project](https://github.com/grafana-operator/grafana-operator)
