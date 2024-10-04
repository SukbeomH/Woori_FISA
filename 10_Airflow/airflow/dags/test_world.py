from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
import pendulum

local_tz = pendulum.timezone("Asia/Seoul")

init_args = {
    'start_date': datetime(2024, 10, 1, tzinfo=local_tz),
}

def print_world():
    print("world")

with DAG(
    dag_id='test_world',
    description='test world_dag',
    default_args=init_args,
    schedule_interval=timedelta(days=1),
    catchup=False,
    tags=['example'],
) as dag:

    t1 = PythonOperator(
        task_id='print_world',
        python_callable=print_world,
    )

    t2 = BashOperator(
        task_id='print_world_bash',
        bash_command='echo world',
    )

    t1 >> t2


