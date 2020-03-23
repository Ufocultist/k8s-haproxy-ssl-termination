#!/bin/bash

# Set docker env for minikube. Comment line below if you'd like to use localhost
eval $(minikube docker-env)

# Build haproxy image with self-signed certificate
docker build ./haproxy -t ssl-termination

# Apply all resources to local k8s
kubectl apply -f deployment.yaml

# Wait for a while 
echo "Pod is deploying, please wait 60 sec, then it'll be exposed" && sleep 60
POD_ID=$(kubectl get pods | grep ssl-termination | awk '{print $1}')
kubectl port-forward ${POD_ID} 1443:443


