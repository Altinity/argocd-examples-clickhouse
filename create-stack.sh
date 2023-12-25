#!/bin/bash
NS=${NAMESPACE:-ch}
REV=${BRANCH:-main}
K8S=${CLUSTER:-'https://kubernetes.default.svc'}

while getopts b: flag
do
    case "${flag}" in
        b) REV=${OPTARG};; # GitHub revision/branch
    case "${flag}" in
        c) K8S=${OPTARG};; # target Kubernetes cluster
    case "${flag}" in
        n) NS=${OPTARG};; # target namespace
    case
	h) echo ${0} [-b revision] [-c cluster] [-n namespace]; exit 0;;
    esac
done

echo "This command will install the analytic stack!"
echo "  Target cluster:   ${K8S}"
echo "  Target namespace: ${NS}"
echo "  Source revision:  ${REV}"
echo -n "Press enter or ^c to cancel: "
read
set -x
echo "*********** Creating namespace ***********"
kubectl create ns ${NS}

argocd app create prometheus-operator-crds \
 --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
 --path apps/prometheus-operator-crds \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}   --revision grafana_operator_dashboard
 argocd app create prometheus-operator \
  --repo https://github.com/Altinity/argocd-examples-clickhouse.git \
  --path apps/prometheus-operator \
  --dest-server https://kubernetes.default.svc --dest-namespace ${NS}   --revision grafana_operator_dashboard
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
