#!/usr/bin/env bash

echo -e "\nDeleting kind k8s cluster..."
kind delete cluster --name $CLUSTER
