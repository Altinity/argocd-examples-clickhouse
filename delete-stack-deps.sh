#!/bin/bash
echo "This command will remove app stack dependencies!" 
echo "Be sure to run delete-stack-apps.sh first"
echo -n "Press enter or ^c to cancel: "
read
set -x
argocd app delete clickhouse-operator --yes
