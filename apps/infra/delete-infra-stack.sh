#!/bin/bash
echo "This command will remove your application stack!"
echo -n "Press enter or ^c to cancel: "
read
set -x

#declare -a applications=(prometheus-operator-crds prometheus-rbac prometheus-operator clickhouse-operator prometheus grafana-operator zookeeper clickhouse grafana grafana-datasource)
declare -a applications=(prometheus-operator-crds prometheus-rbac prometheus-operator prometheus grafana-operator grafana grafana-datasource)

for apps in "${applications[@]}"; do
  echo "*********** Deleting ${apps} ***********"
  argocd app delete ${apps} --yes
done

echo "Now run delete-stack-deps.sh to remove app dependencies"
