#!/bin/bash
NS=${NAMESPACE:-clickhouse}
echo "This command will install the analytic stack in namespace ${NS}"
echo -n "Press enter or ^c to cancel: "
read
set -x
argocd app create clickhouse-operator \
 --repo https://github.com/rahularram1999/argocd-examples-clickhouse.git \
 --revision feature/turtlemint_argocd_clickhouse \
 --path apps/clickhouse-operator \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app create prometheus \
 --repo https://github.com/rahularram1999/argocd-examples-clickhouse.git \
 --revision feature/turtlemint_argocd_clickhouse \
 --path apps/prometheus \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app create grafana \
 --repo https://github.com/rahularram1999/argocd-examples-clickhouse.git \
 --revision feature/turtlemint_argocd_clickhouse \
 --path apps/grafana \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app create zookeeper \
 --repo https://github.com/rahularram1999/argocd-examples-clickhouse.git \
 --revision feature/turtlemint_argocd_clickhouse \
 --path apps/zookeeper \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app create clickhouse \
 --repo https://github.com/rahularram1999/argocd-examples-clickhouse.git \
 --revision feature/turtlemint_argocd_clickhouse \
 --path apps/clickhouse \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app create cloudbeaver \
 --repo https://github.com/rahularram1999/argocd-examples-clickhouse.git \
 --revision feature/turtlemint_argocd_clickhouse \
 --path apps/cloudbeaver \
 --dest-server https://kubernetes.default.svc --dest-namespace ${NS}
argocd app sync clickhouse-operator
argocd app sync prometheus
argocd app sync grafana
argocd app sync zookeeper
argocd app sync clickhouse
argocd app sync cloudbeaver
