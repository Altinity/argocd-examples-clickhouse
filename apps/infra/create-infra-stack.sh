#!/bin/bash
NS=${NAMESPACE:-ch}
echo "This command will install the infra analytic stack in namespace ${NS}"
echo -n "Press enter or ^c to cancel: "
read
set -x
echo "*********** Creating namespace ***********"
kubectl create ns ${NS}

while getopts b: flag
do
    case "${flag}" in
        b) branch=${OPTARG};; # branch
    esac
done
declare -a applications=(prometheus-operator-crds prometheus-rbac prometheus-operator prometheus grafana-operator grafana grafana-datasource)


for apps in "${applications[@]}"; do
  echo "*********** Creating ${apps} ***********"
  if [ -z $branch ]
  then
    echo "*********** Using revision ${branch}"
    argocd app create ${apps} \
      --repo https://github.com/Altinity/argocd-examples-clickhouse.git --path apps/infra/${apps} \
      --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
  else
    argocd app create ${apps} \
          --repo https://github.com/Altinity/argocd-examples-clickhouse.git --path apps/infra/${apps} \
          --dest-server https://kubernetes.default.svc --dest-namespace ${NS} --revision ${branch}
  fi
  echo "*********** Created ${apps} ***********"
  sleep 2
done

sleep 5
for apps in "${applications[@]}"; do
  echo "*********** Syncing ${apps} ***********"
  if [ -z $branch ]
  then
    argocd app sync ${apps}
  else
    argocd app sync ${apps} --revision ${branch}
  fi
done
