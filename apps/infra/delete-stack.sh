#!/bin/bash
DRY_RUN=${DRY_RUN:-no}
ME=${0}

usage() {
  echo "${ME} [-d] [-h]"
  exit $1
}
while getopts "dh" flag
do
    case "${flag}" in
        d) DRY_RUN=yes;; # dry run only; print commands
	h) usage 0;;
	*) usage 1;;
    esac
done

echo "This command will delete the infra stack!"
echo "  Dry run: ${DRY_RUN}"
echo -n "Press enter or ^c to cancel: "
read

declare -a applications=(grafana-datasource grafana-operator grafana prometheus prometheus-operator prometheus-rbac prometheus-operator-crds)
echo "*********** Deleting applications **********"
for app in "${applications[@]}"; do
  echo "----------- Deleting ${app} -----------"
  cmd="argocd app delete ${app} --yes"
  echo "$cmd"

  if [ $DRY_RUN = "no" ]; then
    $cmd
  fi
done
