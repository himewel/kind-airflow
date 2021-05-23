#!/usr/bin/env bash

kubectl port-forward \
    svc/$RELEASE-flower 5555:$PORT \
    --namespace $RELEASE
