#!/usr/bin/env bash

echo -e "\nCreating cluster..."
kind create cluster --name $CLUSTER
echo -e "\nAdding apache/airflow helm chart repo..."
helm repo add apache-airflow https://airflow.apache.org
echo -e "\nUpdating helm charts..."
helm repo update

echo -e "\nCreating k8s namespace..."
kubectl create namespace $NAMESPACE
echo -e "\nInstalling apache-airflow helm chart..."
helm install airflow apache-airflow/airflow \
    --namespace $NAMESPACE
