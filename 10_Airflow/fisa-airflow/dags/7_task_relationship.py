# 7_task_relationship.py

from datetime import datetime, timedelta
from textwrap import dedent

# DAG 객체: 이를 사용하여 DAG를 인스턴스화해야 함
from airflow import DAG

# Operators: 작업을 수행하는 데 필요
from airflow.operators.bash import BashOperator

# 이러한 args는 각 operator의 초기화 중에 작업별로 재정의할 수 있음
default_args = {
    'owner': 'woori-fisa',
    'depends_on_past': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=15),
    # 'email': ['atangi@naver.com'],
    # 'email_on_failure': True,
    # 'email_on_retry': False,
    # 'queue': 'bash_queue',
    # 'pool': 'backfill',
    # 'priority_weight': 10,
    # 'end_date': datetime(2016, 1, 1),
    # 'wait_for_downstream': False,
    # 'dag': dag,
    # 'sla': timedelta(hours=2),
    # 'execution_timeout': timedelta(seconds=300),
    # 'on_failure_callback': some_function,
    # 'on_success_callback': some_other_function,
    # 'on_retry_callback': another_function,
    # 'sla_miss_callback': yet_another_function,
    # 'trigger_rule': 'all_success'
}
with DAG(
    'task-relationship',
    default_args=default_args,
    description='간단한 튜토리얼 DAG',
    schedule_interval=timedelta(days=1),
    start_date=datetime(2024, 3, 25),
    catchup=False,
    tags=['task-relationship'],
) as dag:

    # t1, t2, t3는 operator를 인스턴스화하여 생성된 작업 예시
    t1 = BashOperator(
        task_id='print_date',
        bash_command='date',
    )

    t2 = BashOperator(
        task_id='sleep',
        depends_on_past=False,
        bash_command='sleep 5',
        retries=3,
    )
    t1.doc_md = dedent(
        """\
    #### 작업 문서화
    `doc_md` (markdown), `doc` (일반 텍스트), `doc_rst`, `doc_json`, `doc_yaml`라는 속성을 사용하여 작업을 문서화할 수 있음
    이는 UI의 Task Instance 세부 정보 페이지에서 렌더링됨.
    """
    )

    dag.doc_md = """
    이는 어디서든지 배치될 수 있는 문서화입니다.
    """  # 그렇지 않으면, 이렇게 작성
    templated_command = dedent(
        """
    {% for i in range(5) %}
        echo "{{ ds }}"
        echo "{{ macros.ds_add(ds, 7)}}"
        echo "{{ params.my_param }}"
    {% endfor %}
    """
    )

    t3 = BashOperator(
        task_id='templated',
        depends_on_past=False,
        bash_command=templated_command,
        params={'my_param': '전달한 매개변수'},
    )

    
    t4 = BashOperator(
        task_id='finished',
        bash_command='echo "finished"'
    )

#   추출     변형      적재
#   추출     적재      변형
    t1 >> [t2, t3] >> t4
    # t1 >> t2 >> t4
    # t1 >> t3 >> t4