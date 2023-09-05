#!/bin/bash
NS=${NAMESPACE:-ch}
echo "This command will sync the kubernetes cluster with the state in git for namespace ${NS}"
echo -n "Press enter or ^c to cancel: "
read
set -x
argocd app sync clickhouse-operator
argocd app sync prometheus
argocd app sync grafana
argocd app sync zookeeper
argocd app sync clickhouse
argocd app sync cloudbeaver
