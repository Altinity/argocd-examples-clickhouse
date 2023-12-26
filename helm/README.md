# Helm installation for ClickHouse stacks

Install the hello-clickhouse stack. 
```
helm install hello hello-clickhouse
```

Sync all applications in the stack. 
```
argocd app sync -l application=hello-clickhouse
```

Upgrade the stack. 
```
helm upgrade hello hello-clickhouse
```

Remove the hello-clickhouse stack. 
```
helm uninstall hello
```
