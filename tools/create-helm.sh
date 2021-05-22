#!/usr/bin/env bash

kind create cluster $CLUSTER
helm repo add apache-airflow https://airflow.apache.org
helm repo update

kubectl create namespace $NAMESPACE
helm install airflow apache-airflow/airflow \
    --namespace $NAMESPACE
