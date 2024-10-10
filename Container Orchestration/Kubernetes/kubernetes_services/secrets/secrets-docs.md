<h2 align="center">
Secrets Command and Usage Documentation
</h2>

Handling Private Registry Authentication
If your Docker registry at 172.23.211.28:4484 requires authentication, create a secret in Kubernetes to store your Docker registry credentials:

kubectl command

```bash
kubectl create secret docker-registry regcred-screening-playground \
    --docker-server=172.23.211.28:4484 \
    --docker-username=admin \
    --docker-password=Jbl@4567 \
    -n screening-playground

kubectl create secret docker-registry regcred-screening-live \
    --docker-server=172.23.211.28:4484 \
    --docker-username=admin \
    --docker-password=Jbl@4567 \
    -n screening-live
```

kubectl create secret docker-registry regcred-sms-playground \
    --docker-server=172.23.211.28:4484 \
    --docker-username=admin \
    --docker-password=Jbl@4567 \
    -n sms-playground

kubectl create secret docker-registry regcred-sms-live \
    --docker-server=172.23.211.28:4484 \
    --docker-username=admin \
    --docker-password=Jbl@4567 \
    -n sms-live

kubectl create secret docker-registry regcred-email-live \
    --docker-server=172.23.211.28:4484 \
    --docker-username=admin \
    --docker-password=Jbl@4567 \
    -n email-live






