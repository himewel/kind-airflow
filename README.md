# Kind Airflow

<p>
<img alt="Docker" src="https://img.shields.io/badge/docker-%230db7ed.svg?&style=for-the-badge&logo=docker&logoColor=white"/>
<img alt="Apache Airflow" src="https://img.shields.io/badge/apacheairflow-%23017cee.svg?&style=for-the-badge&logo=apache-airflow&logoColor=white"/>
<img alt="Kubernetes" src="https://img.shields.io/badge/Kubernetes-%23326ce5.svg?&style=for-the-badge&logo=kubernetes&logoColor=white"/>
</p>


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
