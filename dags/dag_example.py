from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago

default_args = {
    "owner": "airflow",
    "retries": 1,
    "concurrency": 1,
    "depends_on_past": True,
}


def hello_world(message):
    print(message)


with DAG(
    dag_id="dag_example",
    schedule_interval="@daily",
    start_date=days_ago(1),
    default_args=default_args,
) as dag:
    bash_task = BashOperator(
        task_id="bash_command",
        bash_command="echo 'Hello World!'",
    )

    python_task = PythonOperator(
        task_id="python_callable",
        python_callable=hello_world,
        op_kwargs={"message": "Hello World!"},
    )

    bash_task >> python_task
