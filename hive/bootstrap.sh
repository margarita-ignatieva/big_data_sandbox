#!/bin/bash
declare -A check_connection_map

check_connection_map[localhost]=22
check_connection_map[postgres]=5432
check_connection_map[hdfs-base]=9000 #datnode ipc address

#todo move to separate script which will be in ubuntu base image
check_connection_to_services() {
echo "im in check conn"
local max_try=100
local retry_seconds=5
local connection_timeout=10

for i in "${!check_connection_map[@]}"
do
try=1
   if [[ "$i" -eq "localhost" ]];then
        sudo service ssh start
    fi
res=$(timeout $connection_timeout bash -c "</dev/tcp/$i/${check_connection_map[$i]}")
until [[ "$res" -eq  0 ]]; do
    if (( $try == $max_try )); then
        echo "[$try/$max_try] i:${check_connection_map[$i]} is still not available; giving up after ${max_try} tries"
        exit 1
    fi
    let "try++"
    sleep $retry_seconds
done
done
}

check_connection_to_services
#check for metastore if exists
#hive -service metastore
/usr/local/hive/bin/schematool -dbType postgres -initSchema 
#https://sparkbyexamples.com/apache-hive/hive-start-hiveserver2-and-beeline/ start hive2 server too
nohup /usr/local/hive --service metastore &

tail -f /dev/null
#/usr/local/hive/bin/schematool -upgradeSchema -dbType postgres -dryRun
