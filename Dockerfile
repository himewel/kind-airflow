FROM apache/airflow

WORKDIR ${AIRFLOW_HOME}

USER root

COPY ./dags ./dags
COPY ./plugins ./plugins
COPY ./include ./include
COPY ./requirements.txt ./requirements.txt
COPY ./packages.txt ./packages.txt

RUN chown airflow:root \
    ./dags \
    ./plugins \
    ./include \
    ./requirements.txt \
    ./packages.txt

RUN apt-get update \
    && xargs \
        --arg-file=./packages.txt \
        apt-get install --yes

USER airflow

RUN pip install --requirement ./requirements.txt
