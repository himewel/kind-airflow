#!/usr/bin/env bash

echo -e "\nDeleting k8s namespace..."
kubectl delete namespace $NAMESPACE

echo -e "\nDeleting kind k8s cluster..."
kind delete cluster --name $CLUSTER
