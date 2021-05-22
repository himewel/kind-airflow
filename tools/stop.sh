#!/usr/bin/env bash

kubectl delete namespace $NAMESPACE
kind delete cluster $CLUSTER
