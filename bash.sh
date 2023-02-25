#!/bin/bash

# Connect to the Kubernetes cluster
kubectl config use-context minikube

# Install the Helm chart for the web application
helm install myapp ./app-helmchart

# Verify that the Deployment, Service, ConfigMap, and Secret have been created
kubectl get deployment myapp
kubectl get service myapp-service
kubectl get configmap myapp-configmap
kubectl get secret myregistrykey

# Check the logs of the application Pod for any errors
POD_NAME=$(kubectl get pod -l app=myapp -o jsonpath="{.items[0].metadata.name}")
kubectl logs $POD_NAME
