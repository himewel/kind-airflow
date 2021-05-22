#!/usr/bin/env bash

echo -e "\nLoading airflow image to k8s..."
kind load docker-image $REPOSITORY:$TAG --name $CLUSTER

echo -e "\nChecking apache-airflow helm updates..."
helm repo add apache-airflow https://airflow.apache.org
helm repo update

echo -e "\nUpgrading helm chart with new image..."
helm upgrade airflow apache-airflow/airflow \
    --namespace $NAMESPACE \
    --set images.airflow.repository=$REPOSITORY \
    --set images.airflow.tag=$TAG
