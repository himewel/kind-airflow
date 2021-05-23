#!/usr/bin/env bash

kubectl port-forward \
    svc/$RELEASE-webserver 8080:$PORT \
    --namespace $RELEASE
