#!/bin/bash

# Get Node
kubectl get nodes

# Get all node
kubectl get all -o wide


#------- Pod ---------


# kubectl describe pod

kubectl describe pod <pod_name>

# kubectl logs:

kubectl logs <pod_name>

# kubectl events:

kubectl get events --sort-by='.metadata.creationTimestamp'

# Pod's Restart Count:

kubectl get pod <pod_name> -o=jsonpath='{.status.containerStatuses[*].restartCount}'




#------- Namespace ---------

# Get namespace
kubectl get ns

# Create namespace
kubectl create namespace namespace-name

# Switch namespace
kubectl config set-context --current --namespace=default

# To check current namespace
kubectl config view --minify | grep namespace:

# Describe namespace
kubectl describe namespace default


# -------- PV, PVC ---------------

# To delete all pv, pvc
kubectl get pv --no-headers | awk '{print $1}' | xargs kubectl delete pv







