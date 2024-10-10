<h2 align="center">
Resource Troubleshooting Command and Usage Documentation
</h2>


Check Service Resolution and Connectivity

Using BusyBox Pod
You can deploy a temporary BusyBox pod to test DNS resolution and network connectivity:
```bash
kubectl run -i --tty --rm debug --image=busybox --restart=Never -- sh
```

Inside the BusyBox pod, use nslookup to check the service resolution:

```bash
nslookup prometheus.istio-system
```
If nslookup is not available, use wget or nc to check connectivity:

```bash
wget http://prometheus.istio-system:9090
```
or

```bash
nc -zv prometheus.istio-system 9090
```