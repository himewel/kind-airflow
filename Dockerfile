FROM apache/airflow

COPY ./dags ./dags
COPY ./plugins ./plugins
COPY ./include ./include

COPY ./requirements.txt ./requirements.txt

RUN pip install --requirement ./requirements.txt
