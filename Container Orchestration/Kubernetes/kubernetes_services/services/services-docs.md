<h2 align="center">
Services Command and Usage Documentation
</h2>

### Port forwarding
```bash
kubectl port-forward svc/jbl-playground-ingress-nginx-controller-metrics -n playground-ingress 10254:10254
```
### Nodeport forwarding
```bash
kubectl expose service jbl-playground-ingress-nginx-controller-metrics --type=NodePort --name=jbl-playground-ingress-nginx-controller-metrics-nodeport -n playground-ingress
```