#!/bin/bash
NAMESPACE=${NAMESPACE:-ch}
REVISION=${BRANCH:-main}
KUBERNETES=${CLUSTER:-'https://kubernetes.default.svc'}
DRY_RUN=${DRY_RUN:-no}
ME=${0}

usage() {
  echo "${ME} [-r revision] [-c cluster] [-n namespace] [-d] [-h]"
  exit $1
}
while getopts "r:c:dn:h" flag
do
    case "${flag}" in
        c) KUBERNETES=${OPTARG};; # target Kubernetes cluster
        d) DRY_RUN=yes;; # dry run only; print commands
        n) NAMESPACE=${OPTARG};; # target namespace
        r) REVISION=${OPTARG};; # GitHub revision/branch
	h) usage 0;;
	*) usage 1;;
    esac
done

echo "This command will install the infra stack!"
echo "  Target cluster:   ${KUBERNETES}"
echo "  Target namespace: ${NAMESPACE}"
echo "  Source revision:  ${REVISION}"
echo "  Dry run:          ${DRY_RUN}"
echo -n "Press enter or ^c to cancel: "
read

declare -a applications=(prometheus-operator-crds prometheus-rbac prometheus-operator prometheus grafana-operator grafana grafana-datasource)

echo "*********** Creating namespace ***********"
kubectl create ns ${NAMESPACE}

echo "*********** Creating apps in Argo CD ***********"
#declare -a applications=(prometheus-operator-crds prometheus-rbac prometheus-operator clickhouse-operator prometheus)
for app in "${applications[@]}"; do
  echo "----------- Creating ${app} ------------"
  cmd="argocd app create ${app} \
--repo https://github.com/Altinity/argocd-examples-clickhouse.git \
--revision ${REVISION} \
--path apps/infra/${app} \
--dest-server ${KUBERNETES} \
--dest-namespace ${NAMESPACE}"
  echo "$cmd"

  if [ $DRY_RUN = "no" ]; then
    $cmd
    sleep 2
  fi
done


echo "*********** Syncing applications **********"
for app in "${applications[@]}"; do
  echo "----------- Syncing ${app} -----------"
  cmd="argocd app sync ${app}"
  echo "$cmd"

  if [ $DRY_RUN = "no" ]; then
    $cmd
    sleep 5
  fi
done
