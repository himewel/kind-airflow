FROM apache/airflow

USER root

COPY ./packages.txt ./packages.txt

RUN apt-get update \
    && xargs --arg-file=packages.txt apt-get install --yes

USER airflow

COPY ./dags ./dags
COPY ./plugins ./plugins
COPY ./include ./include

COPY ./requirements.txt ./requirements.txt

RUN pip install --requirement ./requirements.txt
