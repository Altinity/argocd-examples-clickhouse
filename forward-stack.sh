#!/bin/bash
NS=${NAMESPACE:-ch}
echo "This command will forward ports on the analytic stack in namespace ${NS}"
echo -n "Press enter or ^c to cancel: "
read
set -x
# Port-forward for CloudBeaver SQL editor.
kubectl port-forward svc/cloudbeaver -n ${NS} 8978:8978 &
# Port-forward for Grafana dashboard.
kubectl port-forward svc/grafana -n ${NS} 3000:3000 &
# Port-forward for ClickHouse web UI.
kubectl port-forward svc/clickhouse-argocd -n ${NS} 8123:8123 &
