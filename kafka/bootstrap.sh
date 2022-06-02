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
check_ssh_connection

#add dummy config to start kafka of add it inside kafka ipub precisely

tail -f /dev/null
