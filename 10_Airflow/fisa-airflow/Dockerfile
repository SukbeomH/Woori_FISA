FROM apache/airflow:2.10.2

USER root

RUN apt-get update && apt-get install -y build-essential
RUN apt-get install -y default-libmysqlclient-dev
RUN python -m pip install --upgrade pip

CMD ["webserver"]

