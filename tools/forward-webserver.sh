#!/usr/bin/env bash

kubectl port-forward \
    svc/airflow-webserver 8080:$PORT \
    --namespace $NAMESPACE
