# Kind Airflow

## How to start

- Check if your environment has docker installed and install it if not;
- To setup the k8s cluster and Apache Airflow helm chart run the following commands:
```shell
make build \
&& make start \
    CLUSTER=<YOUR CLUSTER NAME> \
    NAMESPACE=<YOUR K8S NAMESPACE>
```
- Check the webserver status by forward the UI from the k8s pod:
```shell
make forward-webserver \
    PORT=<PORT TO FORWARD THE WEB UI> \
    NAMESPACE=<YOUR K8S NAMESPACE>
```
