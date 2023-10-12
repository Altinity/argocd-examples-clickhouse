#!/bin/bash
NS=${NAMESPACE:-ch}
echo "This command will install the analytic stack in namespace ${NS}"
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

declare -a applications=(prometheus-operator-crds prometheus-rbac prometheus-operator clickhouse-operator prometheus grafana-operator zookeeper clickhouse grafana grafana-datasource mysql-operator-crds mysql-operator mysql)

#helm upgrade -i grafana-operator oci://ghcr.io/grafana-operator/helm-charts/grafana-operator --version v5.3.0 --values apps/grafana-operator/values.yaml --namespace ${NS} --create-namespace
#sleep 5

for apps in "${applications[@]}"; do
  echo "*********** Creating ${apps} ***********"
  if [ -z $branch ]
  then
    echo "*********** Using revision ${branch}"
    argocd app create ${apps} \
      --repo https://github.com/Altinity/argocd-examples-clickhouse.git --path apps/${apps} \
      --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
  else
    argocd app create ${apps} \
          --repo https://github.com/Altinity/argocd-examples-clickhouse.git --path apps/${apps} \
          --dest-server https://kubernetes.default.svc --dest-namespace ${NS} --revision ${branch} --app-namespace ${NS}
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

#argocd app sync mysql-operator-crds --revision add_sink_connector
#argocd app create mysql-operator-crds --repo https://github.com/Altinity/argocd-examples-clickhouse.git --path apps/mysql-operator-crds --dest-server https://kubernetes.default.svc --dest-namespace ch --revision add_sink_connector

argocd app create mysql --repo https://github.com/Altinity/argocd-examples-clickhouse.git --path apps/mysql --dest-server https://kubernetes.default.svc --dest-namespace ch --revision add_sink_connector


#argocd app create prometheus-operator-crds \
# --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
# --path apps/prometheus-operator-crds \
# --dest-server https://kubernetes.default.svc --dest-namespace ${NS}   --revision grafana_operator_dashboard
# argocd app create prometheus-operator \
#  --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
#  --path apps/prometheus-operator \
#  --dest-server https://kubernetes.default.svc --dest-namespace ${NS}   --revision grafana_operator_dashboard
#argocd app create clickhouse-operator \
# --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
# --path apps/clickhouse-operator \
# --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
#
#argocd app create prometheus \
# --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
# --path apps/prometheus \
# --dest-server https://kubernetes.default.svc --dest-namespace ${NS}   --revision grafana_operator_dashboard
# argocd app create grafana-operator \
#  --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
#  --path apps/grafana-operator \
#  --dest-server https://kubernetes.default.svc --dest-namespace ${NS}  --revision grafana_operator_dashboard
#argocd app create zookeeper \
# --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
# --path apps/zookeeper \
# --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
#argocd app create clickhouse \
# --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
# --path apps/clickhouse \
# --dest-server https://kubernetes.default.svc --dest-namespace ${NS}  --revision grafana_operator_dashboard
##argocd app create cloudbeaver \
## --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
## --path apps/cloudbeaver \
## --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
# argocd app create grafana \
#  --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
#  --path apps/grafana \
#  --dest-server https://kubernetes.default.svc --dest-namespace ${NS} --revision grafana_operator_dashboard
#  argocd app create grafana-datasource \
#  --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
#    --path apps/grafana-datasource \
#    --dest-server https://kubernetes.default.svc --dest-namespace ${NS} --revision grafana_operator_dashboard
#argocd app sync prometheus-operator-crds
#argocd app sync clickhouse-operator
##argocd app sync prometheus
#argocd app sync grafana-operator
#argocd app sync zookeeper
#argocd app sync clickhouse
##argocd app sync cloudbeaver
#argocd app sync grafana
#argocd app sync grafana-datasource
