#!/bin/bash

{
sleep 10

/usr/local/bin/airflow db init


airflow users create \
    --email EMAIL --firstname firstname \
    --lastname lastname --password admin \
    --role Admin --username admin

/usr/local/bin/airflow webserver
}

#to run scheduler
# /usr/local/bin/airflow scheduler

tail -f /dev/null

