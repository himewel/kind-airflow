#!/usr/bin/env bash

kubectl port-forward \
    svc/airflow-flower 5555:$PORT \
    --namespace $NAMESPACE
