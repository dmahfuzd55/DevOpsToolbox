
<h2 align="center">
Linux Command and Usage Documentation
</h2>

#### Kubernetes cluster network
```bash
kubectl get pods --all-namespaces -o wide | grep -E "(flannel|calico)"
```

#### Get terminating resource
```bash
api-resources --verbs=list --namespaced -o name   | xargs -n 1 kubectl get --show-kind --ignore-not-found -n namespace
```

#### Forcely delete any pod
```bash
kubectl delete pod/cattle-cluster-agent-578479c8c-pgzj9 -n cattle-system --grace-period=0 --force
```