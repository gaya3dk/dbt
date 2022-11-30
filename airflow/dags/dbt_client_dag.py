from datetime import timedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import datetime
from airflow.utils.dates import timedelta

DBT_DIR = "/home/gasr/bankingcircle/workspace/dbt/"

with DAG(
    dag_id='dbt_client_dag',
    start_date=datetime(2022, 11, 27),
    description='An Airflow DAG to create client models in transformed layer',
    schedule_interval=timedelta(days=1),
) as dag:


    dbt_run_account_status = BashOperator(
        task_id='run_client_by_account_status',
        bash_command=f"""
            cd {DBT_DIR} &&
            make install &&
            make run SELECTOR=client_by_account_status
        """,
        dag=dag
    )
    dbt_run_value_volume = BashOperator(
        task_id='run_client_value_volume',
        bash_command=f"""
            cd {DBT_DIR} &&
            make install &&
            make run SELECTOR=client_value_volume
        """,
        dag=dag
    )
    dbt_test = BashOperator(
        task_id='test_client_models',
        bash_command=f"""
            cd {DBT_DIR} &&
            make test SELECTOR=transformed
        """,
        dag=dag
    )


    dbt_run_account_status >> dbt_test
    dbt_run_value_volume >> dbt_test