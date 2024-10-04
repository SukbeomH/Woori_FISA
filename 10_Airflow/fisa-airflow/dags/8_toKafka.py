from datetime import datetime, timedelta
from textwrap import dedent
from airflow import DAG
from airflow.operators.bash import BashOperator


default_args = {
    'owner': 'woori-fisa',
    'depends_on_past': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=1),
}

with DAG(
    'kafka-connect',
    default_args=default_args,
    description='10_kafka와 연동되는 Dag',
    schedule_interval=timedelta(minutes=1),
    start_date=datetime(2024, 3, 25),
    catchup=False,
    tags=['service'],
) as dag:

    t1 = BashOperator(
        task_id='run-task',
        bash_command='curl http://host.docker.internal:5000/hello',
    )

    t1.doc_md = dedent(
        """\
    #### 자동호출
    t1이라는 task를 통해 docker container 외부의 flask API /hello를 1분마다 호출합니다.
    """
    )

    dag.doc_md = """
    kafka의 tracking-log라는 토픽을 통해 logstash -> elasticsearch -> kibana로 연결된 파이프라인입니다
    """  

t1