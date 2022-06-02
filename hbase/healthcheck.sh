#!/bin/bash

echo "executing hbase list command"



echo 'list' | hbase shell -n
status_code=$?

#write it to log file
echo ${status_code}

if [ ${status_code} -ne 0 ]; then
  echo "The command may have failed."
fi

#for master error https://debugah.com/solved-hbase-list-error-org-apache-hadoop-hbase-pleaseholdexception-master-is-initializing-6896/

#cd $HBASE_HOME/bin
#./hbase zkcli
#ls /
#rmr /hbase
#ls /
#add cleaned successfully if every command was executed
