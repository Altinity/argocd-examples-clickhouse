#!/bin/bash

# This script is used to login to argocd server using the default password stored in secrets.
password=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`
argocd login localhost:8080 --username=admin --password=${password} --insecure