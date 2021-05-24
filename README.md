# Kind Airflow

<p>
<img alt="Docker" src="https://img.shields.io/badge/docker-%230db7ed.svg?&style=for-the-badge&logo=docker&logoColor=white"/>
<img alt="Apache Airflow" src="https://img.shields.io/badge/apacheairflow-%23017cee.svg?&style=for-the-badge&logo=apache-airflow&logoColor=white"/>
<img alt="Kubernetes" src="https://img.shields.io/badge/Kubernetes-%23326ce5.svg?&style=for-the-badge&logo=kubernetes&logoColor=white"/>
</p>

This repo presents a set of tools to start with [Apache Airflow helm chart](https://airflow.apache.org/docs/helm-chart).

## Repo structure

```
├── dags/               <- airflow python dag files
├── include/            <- python imports to dag files
├── plugins/            <- airflow plugins
├── tools/              <- bash scripts and Dockerfile to manipulate k8s
├── Dockerfile          <- docker container to release the dag files
├── packages.txt        <- apt packages to be installed in the docker build
├── requirements.txt    <- python packages to be installed in the docker build
└── settings.yaml       <- helm settings of airflow helm chart
```

## How to start

- Check if your environment has docker installed and install it if not;
- To setup the k8s cluster and Apache Airflow helm chart run the following commands:

```shell
# build the docker image to manage the cluster
make build
# create a cluster and install the helm chart
make start \
    CLUSTER=<YOUR CLUSTER NAME> \
    RELEASE=<YOUR K8S NAMESPACE>
```

- Check the webserver status by forward the UI from the k8s pod:

```shell
make forward-webserver \
    PORT=<PORT TO FORWARD THE WEB UI> \
    RELEASE=<YOUR K8S NAMESPACE>
```

- The same can be done with flower:

```shell
make forward-flower \
    PORT=<PORT TO FORWARD THE WEB UI> \
    RELEASE=<YOUR K8S NAMESPACE>
```

- To delete the cluster and remove the k8s namespace:

```shell
make stop \
    RELEASE=<YOUR K8S NAMESPACE>
```

- To release a new version of the dag files, build the Dockerfile and load it to kind:

```shell
docker build . --tag <YOUR IMAGE NAME>:<YOUR IMAGE TAG>
make start \
    CLUSTER=<YOUR CLUSTER NAME> \
    DOCKERIMAGE=<YOUR IMAGE NAME>:<YOUR IMAGE TAG>
    RELEASE=<YOUR K8S NAMESPACE>
```
