from airflow import DAG
from airflow.decorators import task
from datetime import datetime

@task
def print_hello():
    print("hello!")
    return "hello!"

@task
def print_goodbye():
    print("goodbye!")
    return "goodbye!"

with DAG(
    dag_id = 'HelloWorld_v2',
    start_date = datetime(2023,8,15),  # 2024년 3월 25일부터 가져오는 게 아니라 2923년 8월 15일부터 가져와야함
    catchup=True, # 이전에 실행하지 않은 DAG에 대해 실행 여부를 결정합니다.
    tags=['example'],
    schedule = '37 10 * * *'
) as dag:
    
    # Assign the tasks to the DAG in order
    print_hello() >> print_goodbye()
