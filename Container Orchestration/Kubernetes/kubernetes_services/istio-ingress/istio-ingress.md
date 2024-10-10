<h2 align="center">
Istio Command and Usage Documentation
</h2>

### Install Istio(single ingress gateway)
Ensure Istio is installed and running in your cluster. You can install Istio using the following command (assuming you have already installed the Istio CLI):

```bash
istioctl install --set profile=default
```
Make sure Istio’s core components (like the ingress gateway, pilot, etc.) are running:

```bash
kubectl get pods -n istio-system
```

### Install Istio(multi ingress gateway)

Install multi ingress gateway istio need following istio-ingress.yaml file

```bash
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  name: multi-ingress-gateway
  namespace: istio-system # The namespace where the Istio resources will be deployed, usually istio-system.
spec:
  components:
    ingressGateways:
      - name: playground-istio # The name of the Ingress Gateway.
        namespace: istio-system # The namespace in which this gateway will operate.
        enabled: true # Whether this gateway is enabled.
        label:
          istio: playground-istio # A label for the gateway. Useful for matching in VirtualService configurations.
        k8s:
          service:
            type: LoadBalancer # The type of Kubernetes service. LoadBalancer exposes the service externally with a cloud provider's load balancer.
            loadBalancerIP: 172.30.38.23
      - name: live-istio
        namespace: istio-system
        enabled: true
        label:
          istio: live-istio
        k8s:
          service:
            type: LoadBalancer
            loadBalancerIP: 172.30.38.32
```   

Apply this configuration:
```bash
kubectl apply -f istio-ingress.yaml
```

### Enable Istio Injection in the Namespace
Enable automatic sidecar injection for the middleware-istio-playground namespace (if it is not already enabled):
```bash
kubectl label namespace middleware-istio-playground istio-injection=enabled
```

unlabeled istio injection
```bash
kubectl label namespace screening-live istio-injection-
```


To have the Istio sidecar (envoy) injected into your pods, you need to redeploy the accountprefetch-istio-playground deployment. Delete the pod so that it gets recreated with the sidecar proxy:
```bash
kubectl rollout restart deployment accountprefetch-istio-playground -n middleware-istio-playground
```

Verify the sidecar is injected by checking the pod details:
```bash
kubectl get pods -n middleware-istio-playground
kubectl describe pod <pod-name> -n middleware-istio-playground
```
You should see two containers in the pod: one for your app and one for the Istio proxy.


### Expose the Service with an Istio VirtualService and Gateway

Create a Gateway and VirtualService :

Define a Gateway that allows external traffic to access the service through Istio's ingress gateway and Create a VirtualService that defines the routing rules for your service.
```bash
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: middleware-playground-gateway
  namespace: middleware-istio-playground
spec:
  selector:
    istio: live-istio # Use Istio's ingress gateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"

---

apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: middleware-playground-vs
  namespace: middleware-istio-playground
spec:
  hosts:
  - "*"
  gateways:
  - middleware-playground-gateway
  http:
  - match:
    - uri:
        prefix: /playground
    route:
    - destination:
        host: accountprefetch-istio-playground
        port:
          number: 7788
```

### Traffic metrics collections


Prometheus

Prometheus is an open source monitoring system and time series database. You can use Prometheus with Istio to record metrics that track the health of Istio and of applications within the service mesh. You can visualize metrics using tools like Grafana and Kiali.

Installation site
```bash
https://istio.io/latest/docs/ops/integrations/prometheus/
```

Quick start
Istio provides a basic sample installation to quickly get Prometheus up and running:
```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.23/samples/addons/prometheus.yaml
```
This will deploy Prometheus into your cluster. This is intended for demonstration only, and is not tuned for performance or security.


Verify Prometheus
```bash
kubectl get all -n istio-system
```

Port forward to check
```bash
kubectl port-forward svc/jbl-playground-ingress-nginx-controller-metrics -n playground-ingress 10254:10254
```

Expose to nodeport
```bash
kubectl expose service jbl-playground-ingress-nginx-controller-metrics --type=NodePort --name=jbl-playground-ingress-nginx-controller-metrics-nodeport -n playground-ingress
```

Kiali

Kiali is an observability console for Istio with service mesh configuration and validation capabilities. It helps you understand the structure and health of your service mesh by monitoring traffic flow to infer the topology and report errors. Kiali provides detailed metrics and a basic Grafana integration, which can be used for advanced queries. Distributed tracing is provided by integration with Jaeger.


Installation
```bash
https://istio.io/latest/docs/ops/integrations/kiali/
```
Quick start

Istio provides a basic sample installation to quickly get Kiali up and running:
```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.23/samples/addons/kiali.yaml
```
This will deploy Kiali into your cluster. This is intended for demonstration only, and is not tuned for performance or security.

Verify Prometheus
```bash
kubectl get all -n istio-system
```

Port forward to check
```bash
kubectl port-forward svc/jbl-playground-ingress-nginx-controller-metrics -n playground-ingress 10254:10254
```

Expose to nodeport
```bash
kubectl expose service jbl-playground-ingress-nginx-controller-metrics --type=NodePort --name=jbl-playground-ingress-nginx-controller-metrics-nodeport -n playground-ingress
```

Grafana
Grafana is an open source monitoring solution that can be used to configure dashboards for Istio. You can use Grafana to monitor the health of Istio and of applications within the service mesh.

Installation
```bash
https://istio.io/latest/docs/ops/integrations/grafana/
```

Configuration
While you can build your own dashboards, Istio offers a set of preconfigured dashboards for all of the most important metrics for the mesh and for the control plane.

a. Mesh Dashboard provides an overview of all services in the mesh.
b. Service Dashboard provides a detailed breakdown of metrics for a service.
c. Workload Dashboard provides a detailed breakdown of metrics for a workload.
d. Performance Dashboard monitors the resource usage of the mesh.
e. Control Plane Dashboard monitors the health and performance of the control plane.
f. WASM Extension Dashboard provides an overview of mesh wide WebAssembly extension runtime and loading state.
g. There are a few ways to configure Grafana to use these dashboards:

Quick start
Istio provides a basic sample installation to quickly get Grafana up and running, bundled with all of the Istio dashboards already installed:
```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.23/samples/addons/grafana.yaml
```
This will deploy Grafana into your cluster. This is intended for demonstration only, and is not tuned for performance or security.

Verify Prometheus
```bash
kubectl get all -n istio-system
```

Port forward to check
```bash
kubectl port-forward svc/jbl-playground-ingress-nginx-controller-metrics -n playground-ingress 10254:10254
```

Expose to nodeport
```bash
kubectl expose service jbl-playground-ingress-nginx-controller-metrics --type=NodePort --name=jbl-playground-ingress-nginx-controller-metrics-nodeport -n playground-ingress
```



