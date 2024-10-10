<h2 align="center">
Helm Command and Usage Documentation
</h2>

#### 📰 Helm Installation
https://helm.sh/docs/intro/install/

#### 📰 Installs a chart into Kubernetes.
```bash
helm install
```


#### 📰 Upgrades a release to a new version of a chart.
```bash
helm upgrade
```

#### 📰 Uninstalls a release from Kubernetes.
```bash
helm uninstall
```
#### 📰 Lists releases deployed in Kubernetes
```bash
helm list

### To filter by release name:
helm list --filter my-release

### To filter by namespace:
helm list --namespace my-namespace

### To get detailed information about a specific release:
helm list -n my-namespace --all my-release
```

#### 📰 Displays the status of a named release
```bash
helm status
```

#### 📰 Rolls back a release to a previous revision
```bash
helm rollback
```

#### 📰 Searches for Helm charts in repositories
```bash
helm search
```

#### 📰 Adds a chart repository to Helm
```bash
helm repo add
```

#### 📰 Updates the local repository cache
```bash
helm repo update
```

#### 📰 Manages chart dependencies
```bash
helm dependency
```