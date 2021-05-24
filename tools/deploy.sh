#!/usr/bin/env bash

# check if the cluster already exists
match_cluster=$(kind get clusters | grep $CLUSTER$)
if [[ "$match_cluster" = "$CLUSTER" ]]; then
    echo -e "\nCluster $CLUSTER already exists..."
else
    echo -e "\nCreating cluster..."
    kind create cluster --name $CLUSTER
fi

# check if the kubectl namespace already exists
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

# check if a docker image needs to be loaded
if [ -z "$DOCKERIMAGE" ]; then
    echo -e "Any docker image to load to kind..."
else
    echo -e "Loading image to kind cluster..."
    kind load docker-image \
        --name $CLUSTER \
        $DOCKERIMAGE
fi

# upgrade helm chart
echo -e "\nInstalling apache-airflow helm chart..."
helm upgrade \
    --install \
    --namespace $RELEASE \
    --repo https://airflow.apache.org \
    --values=$HOME/settings.yaml \
    $RELEASE airflow
