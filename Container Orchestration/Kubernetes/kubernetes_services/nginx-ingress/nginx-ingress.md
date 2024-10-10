<h2 align="center">
Nginx Ingress Command and Usage Documentation
</h2>

#### 📰 To install nginx ingess

#### Setting Up Nginx Ingress with Kubernetes

Steps:

1. Set Up Load Balancer Service
   First, set up a LoadBalancer service. The IP address of this service will be used in the Ingress resource.

2. Install Ingress Controller
   Next, install the Nginx Ingress Controller. This will manage and route incoming traffic based on your Ingress rules.

3. Create Pods and Services
   Create your application Pods and expose them using ClusterIP services. These services will be used by the Ingress resource to perform load balancing and routing.

4. Create Nginx Ingress Resource
   Finally, create an Ingress resource to define the routing rules. Specify the service names and port numbers for each route to direct traffic to the appropriate Pods.


#### Installation

https://kubernetes.github.io/ingress-nginx/deploy/

1. Create Namespace

```bash
kubectl create namespace ingress-nginx
```

2. Install cards
```bash
helm pull oci://ghcr.io/nginxinc/charts/nginx-ingress --untar --version 1.2.0

cd nginx-ingress

kubectl apply -f crds/ -n ingress-nginx
```

4. If previous install nginx ingress then first remove IngressClass

```bash
kubectl delete ingressclass nginx
```


5. Install nginx ingress

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install playground-ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx
```

Ingress for live
```bash
# Set IngressClassName
  
  # nginx ingress for live
  helm install jbl-live ingress-nginx/ingress-nginx \
  --namespace live-ingress \
  --set controller.ingressClass=jbl-live \
  --set controller.ingressClassResource.name=jbl-live \
  --set controller.service.type=LoadBalancer \
  --set controller.service.loadBalancerIP=172.30.38.35
```

Ingress for playground
```bash
  # nginx ingress for playground
  helm install jbl-playground ingress-nginx/ingress-nginx \
  --namespace playground-ingress \
  --set controller.ingressClass=jbl-playground\
  --set controller.ingressClassResource.name=jbl-playground \
  --set controller.service.type=LoadBalancer \
  --set controller.service.loadBalancerIP=172.30.38.23 \
  --set controller.service.ports.http=8844
```

Ingress metrics collection
```bash
  # nginx ingress for metrics collection
  helm upgrade jbl-playground ingress-nginx/ingress-nginx \
  --namespace playground-ingress \
  --set controller.ingressClass=jbl-playground \
  --set controller.ingressClassResource.name=jbl-playground \
  --set controller.service.type=LoadBalancer \
  --set controller.service.loadBalancerIP=172.30.38.23 \
  --set controller.service.ports.http=8844 \
  --set controller.metrics.enabled=true \
  --set controller.metrics.serviceMonitor.enabled=true
  --set controller.metrics.service.annotations."prometheus\.io/scrape"="true" \
  --set controller.metrics.service.annotations."prometheus\.io/port"="10254"
```

Check metrics controller is okay or not
```bash
kubectl get all -n playground-ingress
```

Check metrics cntroller collect the metrics
```bash
# expose with port forwarding
kubectl port-forward svc/jbl-playground-ingress-nginx-controller-metrics -n playground-ingress 10254:10254

curl http://localhost:10254/metrics

# expose with nodeport
kubectl expose service jbl-playground-ingress-nginx-controller-metrics --type=NodePort --name=jbl-playground-ingress-nginx-controller-metrics-nodeport -n playground-ingress

```

  


# Inspect Deployment Manifest
```bash
kubectl get deployment my-ingress-nginx-controller -n ingress-nginx -o yaml
```
# Edit Deployment Manifest
```bash
kubectl edit deployment my-ingress-nginx-controller -n ingress-nginx
```


#### 📰 Verify NGINX Ingress Installation
```bash
kubectl get pods -n ingress-nginx

kubectl get services -n ingtess-nginx
```

#### 📰 Create an Ingress for the Test Applications
```bash
kubectl -n default apply -f web-app-ingress.yml

kubectl -n default get ingress
```


#### 📰 Unistall INGINX Ingress
```bash
helm list -n ingress-nginx
```

```bash
helm uninstall jbl-ingress-nginx -n ingress-nginx
```



#### 📰 Create NGINX Resource

1. Check nginx resource

```bash
kubectl get ingress
```

2. Create nginx resource

```bash
kubectl create -f web_app_ingress.yaml
```

#### 📰 Verify nginx application


```bash
curl ingress-example.com/service1
curl ingress-example.com/service2
curl ingress-example.com/service3


curl -H "Host: ingress-example.com" http://172.30.38.35/service1
curl -H "Host: ingress-example.com" http://172.30.38.35/service2
curl -H "Host: ingress-example.com" http://172.30.38.35/service3
```

#### Check API in pod

```bash
kubectl get all -n middleware-playground-ingress

kubectl exec -it accountprefetch-playground-56777bb5d7-b79gg -n middleware-playground-ingress -- /bin/bash

nodejs -v

curl -X POST http://localhost:7788/playground/v7/Account/AccountPrefetch \
     -H "Content-Type: application/json" \
     -d '{
            "AcctNum": "01420315000959"
         }'

curl -X POST http://localhost:7784/playground/v7/Customer/EnquireCustomerLinkedAccounts \
     -H "Content-Type: application/json" \
     -d '{
            "CustNumber": "01420315000959"
         }'

curl -X POST http://localhost:4080/playground/v7/Customer/ExtensiveNameSearch \
     -H "Content-Type: application/json" \
     -d '{
    "header": {
        "Uid": "43242"
    },
    "data": {
        "StrtFrm": "", 
        "CustLastName": "", 
        "CustFirstName": "", 
        "CustMidName": "",
        "RelCode": "",
        "MotherName": "", 
        "CustShrtName": "", 
        "Brch": "", 
        "DtOfBirth": "17101992",
        "Todt": "", 
        "OldCustNum": "", 
        "IdNum": "19921317913000100", 
        "IdTyp": "", 
        "DoorFlatNum": "", 
        "BldgSociety": "", 
        "StRoadName": "", 
        "LocalityVill": "", 
        "PstCode": "", 
        "ResdntPhn": "01937093841", 
        "Thana": "", 
        "SubOfc": "", 
        "FatherName": "", 
        "SpouseName": "" 
    }
}'
```

#### Using curl to Make a POST Request

```bash
curl -X POST http://ingress-example.com/playground/v7/Account/AccountPrefetch \
     -H "Content-Type: application/json" \
     -d '{
            "AcctNum": "01420315000959"
         }'

curl -X POST http://172.30.38.35/playground/v7/Customer/EnquireCustomerLinkedAccounts \
     -H "Content-Type: application/json" \
     -d '{
            "CustNumber": "01420315000959"
         }'

curl -X POST http://ingress-example.com/playground/v7/Customer/EnquireCustomer \
     -H "Content-Type: application/json" \
     -d '{
            "CustNumber": "01420315000959"
         }'
```




#### 📰 Troubleshooting

1. Verify Backend Services
Ensure that the backend services (web-app, web-app-green, web-app-yellow) are running and accessible.

```bash
kubectl get services
```

2. Check Service Endpoints
Verify that the services have endpoints and are correctly routing traffic to the pods.

```bash
kubectl get endpoints
```

3. Check pod inside

```bash
# to go inside pod
kubectl exec -it web-app-7457589db6-ljrrm -- /bin/sh

# check nginx is okay or not
nginx -t

# check nginx configuration file
cat /etc/nginx/nginx.conf

# check nginx web serber is okay or not
curl http://localhost
```

4. Check Ingress

```bash
# Check Ingress Controller Logs
kubectl logs <nginx-ingress-controller-pod-name> -n ingress-nginx

kubectl logs -l app.kubernetes.io/name=ingress-nginx -n ingress-nginx

# Validate Ingress Controller Configuration
kubectl exec -it <nginx-ingress-controller-pod-name> -n ingress-nginx -- cat /etc/nginx/nginx.conf
```

5. If getting following error

Run following command

```bash
#kubectl apply -f web_app_ingress_ip.yaml
#Error from server (InternalError): error when creating "web_app_ingress_ip.yaml": Internal error occurred: failed calling webhook "validate.nginx.ingress.kubernetes.io": failed to call webhook: Post "https://ingress-nginx-controller-admission.ingress-nginx.svc:443/networking/v1/ingresses?timeout=10s": service "ingress-nginx-controller-admission" not found

kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
```





