#!/bin/bash

#port and server should be passed as env variables
server=localhost
port=22
connection_timeout=5

check_ssh_connection() {
timeout $connection_timeout bash -c "</dev/tcp/$server/$port"
if [ $? == 0 ];then
   echo "SSH Connection to $server over port $port is possible"
else
#todo add if check - if key already exists
   echo "Trying to establish SSH connection to $server over port $port"
        #start ssh
        sudo service ssh start
fi
}

start_hadoop_services() {
if [ ! -d "${HADOOP_HOME}/data/dfs/datanode" ]
then 
   echo "no datanode dir"
fi

if [ ! -d "${HADOOP_HOME}/data/dfs/namenode" ]
then 
    echo "no namenode dir"
fi

#check if datanode directory is empty
if [[ ! $(ls -A ${HADOOP_HOME}/data/dfs/datanode) ]]
then
    #incompitable cluster ids https://www.its404.com/article/taotoxht/42713103 temp workaround
    rm -Rf /tmp/hadoop-root/*
    rm -Rf ${HADOOP_HOME}/data/dfs/datanode/*
    #format namenode
    #add check if some data exists in hdfs - not the first run
    /usr/local/hadoop/bin/hdfs namenode -format
fi

#start hadoop cluster
/usr/local/hadoop/sbin/start-dfs.sh
/usr/local/hadoop/sbin/start-yarn.sh
}


#todo add health check for all services running or just run healthcheck skripts elsewhere 

check_ssh_connection
start_hadoop_services 

tail -f /dev/null
