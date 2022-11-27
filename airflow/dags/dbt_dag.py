from datetime import timedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import datetime
from airflow.utils.dates import timedelta

DBT_DIR = "/home/gasr/bankingcircle/workspace/dbt/"

with DAG(
    dag_id='dbt_dag',
    start_date=datetime(2022, 11, 27),
    description='An Airflow DAG to run dbt commands',
    schedule_interval=timedelta(days=1),
) as dag:


    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command=f"""
            cd {DBT_DIR} &&
            make run
        """,
        dag=dag
    )
    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command=f"""
            cd {DBT_DIR} &&
            make test
        """,
        dag=dag
    )


    dbt_run >> dbt_test