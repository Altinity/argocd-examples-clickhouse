#!/bin/bash
NS=${NAMESPACE:-ch}
echo "This command will install the analytic stack in namespace ${NS}"
echo -n "Press enter or ^c to cancel: "
read
set -x
echo "*********** Creating namespace ***********"
kubectl create ns ${NS}

#helm upgrade -i grafana-operator oci://ghcr.io/grafana-operator/helm-charts/grafana-operator --version v5.3.0 --values apps/grafana-operator/values.yaml --namespace ${NS} --create-namespace
#sleep 5
argocd app create clickhouse-operator \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/clickhouse-operator \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app create prometheus \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/prometheus \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
 argocd app create grafana-operator \
  --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
  --path apps/grafana-operator \
  --dest-server https://kubernetes.default.svc --dest-namespace ${NS}  --revision grafana_operator_dashboard
argocd app create zookeeper \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/zookeeper \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app create clickhouse \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/clickhouse \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app create cloudbeaver \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/cloudbeaver \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
 argocd app create grafana \
  --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
  --path apps/grafana \
  --dest-server https://kubernetes.default.svc --dest-namespace ${NS} --revision grafana_operator_dashboard
  argocd app create grafana-datasource \
  --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
    --path apps/grafana-datasource \
    --dest-server https://kubernetes.default.svc --dest-namespace ${NS} --revision grafana_operator_dashboard
argocd app sync clickhouse-operator
argocd app sync prometheus
argocd app sync grafana-operator
argocd app sync zookeeper
argocd app sync clickhouse
argocd app sync cloudbeaver
argocd app sync grafana
argocd app sync grafana-datasource