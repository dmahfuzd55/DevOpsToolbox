<h2 align="center">
MetalLB Command and Usage Documentation
</h2>


#### 📰 To install metallb follow officieal documents

https://metallb.universe.tf/installation/


Verify MetallB Installation
```bash
kubectl -n metallb-system get pods

kubectl api-resources| grep metallb
```


#### 📰 Configuration

1. ▶️ Defining The IPs To Assign To The Load Balancer Services
```yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: first-pool
  namespace: metallb-system
spec:
  addresses:
  - 172.16.16.121-172.16.16.122
```

2. ▶️ L2 Advertisement
```yaml
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: metallb-l2
  namespace: metallb-system
spec:
  ipAddressPools:
  - first-pool
  ```

3. ▶️ To check assing ip address range
   ```bash
   kubectl get ipaddresspool -n metallb-system
   ```

4. ▶️ Deploy Test Application
   ```bash
   kubectl -n default apply -f web-app-deployment.yml
   ```
5. ▶️ Verify MetallB assigned an IP address
   
   ```bash
   kubectl -n default get pods
   
   kubectl -n default get services
   ```


If face any issue of pods
```bash
kubectl logs metallb-speaker-7t88x -n metallb-system -c cp-frr-files
```









  








