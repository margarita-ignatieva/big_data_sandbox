
# =============================================================================
# ========== Download airflow
# =============================================================================
FROM ubuntu_base AS base

RUN apt-get update && \ 
    sudo apt-get update && apt-get install --no-install-recommends  -y build-essential python3.6 python3-pip python3-dev && \
    pip3 install --upgrade pip setuptools && \
    pip3 install apache-airflow['postgres'] && \
    apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# todo add dags folder to shared volumes

RUN sed -i 's/\(executor = \).*/\1LocalExecutor/' /usr/local/lib/python3.6/dist-packages/airflow/config_templates/default_airflow.cfg
RUN sed -i 's/\(sql_alchemy_conn = \).*/\1postgresql+psycopg2:\/\/airflow:airflow@postgres\/airflow/' /usr/local/lib/python3.6/dist-packages/airflow/config_templates/default_airflow.cfg

COPY bootstrap.sh /usr/local
RUN chmod +x /usr/local/bootstrap.sh 

ENTRYPOINT ["/usr/local/bootstrap.sh"]

EXPOSE 8080



