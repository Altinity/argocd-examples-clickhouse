#!/bin/bash
echo "This command will remove your application stack!" 
echo -n "Press enter or ^c to cancel: "
read
set -x
argocd app delete clickhouse --yes
argocd app delete zookeeper --yes
argocd app delete cloudbeaver --yes
argocd app delete grafana --yes
argocd app delete prometheus --yes
echo "Now run delete-stack-final.sh to remove app dependencies"
