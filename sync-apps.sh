#!/bin/bash
NS=${NAMESPACE:-ch}
echo "This command will sync the kubernetes cluster with the state in git for namespace ${NS}"
echo -n "Press enter or ^c to cancel: "
read
set -x

while getopts b: flag
do
    case "${flag}" in
        b) branch=${OPTARG};; # branch
    esac
done
declare -a applications=(prometheus-operator-crds prometheus-rbac prometheus-operator clickhouse-operator prometheus grafana-operator zookeeper clickhouse grafana grafana-datasource)
for apps in "${applications[@]}"; do
  echo "*********** Syncing ${apps} ***********"
  if [ -z $branch ]
  then
    argocd app sync ${apps}
  else
    argocd app sync ${apps} --revision ${branch}
  fi
done