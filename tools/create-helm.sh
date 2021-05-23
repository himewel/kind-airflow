#!/usr/bin/env bash

match_cluster=$(kind get clusters | grep $CLUSTER$)
if [[ "$match_cluster" = "$CLUSTER" ]]; then
    echo -e "\nCluster $CLUSTER already exists..."
else
    echo -e "\nCreating cluster..."
    kind create cluster --name $CLUSTER
fi

match_namespace=$(\
    kubectl get namespace \
        --output=custom-columns=:metadata.name \
    | grep $RELEASE$)
if [[ "$match_namespace" = "$RELEASE" ]]; then
    echo -e "\nNamespace $RELEASE already exists..."
else
    echo -e "\nCreating namespace..."
    kubectl create namespace $RELEASE
fi

echo -e "\nInstalling apache-airflow helm chart..."
helm upgrade \
    --install \
    --namespace $RELEASE \
    --repo https://airflow.apache.org \
    --values=$HOME/settings.yaml \
    $RELEASE airflow
