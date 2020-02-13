#!/bin/bash

# Build haproxy image with self-signed certificate
docker build ./haproxy -t ssl-termination

# Apply all resources to local k8s
kubectl apply -f ./

# Wait for a while 
echo "Pod is deploying, please wait 20 sec, then it'll be exposed"
POD_ID=$(kubectl get pods | grep ssl-termination | awk '{print $1}')
kubectl port-forward ${POD_ID} 1443:443


