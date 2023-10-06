#!/bin/bash
NS=${NAMESPACE:-ch}
echo "This command will sync the kubernetes cluster with the state in git for namespace ${NS}"
echo -n "Press enter or ^c to cancel: "
read
set -x
declare -a applications=(prometheus-operator-crds prometheus-rbac prometheus-operator clickhouse-operator prometheus grafana-operator zookeeper clickhouse grafana grafana-datasource)
for apps in "${applications[@]}"; do
  echo "*********** Syncing ${apps} ***********"
  argocd app sync ${apps}
done