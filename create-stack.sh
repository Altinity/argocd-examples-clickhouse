#!/bin/bash
NS=${NAMESPACE:-ch}
echo "This command will install the analytic stack in namespace ${NS}"
echo -n "Press enter or ^c to cancel: "
read
set -x
argocd app create prometheus \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/prometheus \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app create grafana \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/grafana \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app create clickhouse \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/clickhouse \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app create zookeeper \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/zookeeper \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app create cloudbeaver \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/cloudbeaver \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app sync prometheus
argocd app sync grafana
argocd app sync zookeeper
argocd app sync clickhouse
argocd app sync cloudbeaver
