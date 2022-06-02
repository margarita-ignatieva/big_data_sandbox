#!/bin/bash 

#while cycle for checkin logs folder 

sudo service ssh start

declare -a remote_kernels

remote_kernels=(spark hive hdfs-base hbase kafka)

for i in "${remote_kernels[@]}"
do
    remote_ikernel manage --add \
   --kernel_cmd="ipython kernel -f {connection_file}" \
   --name="$i" \
   --interface=ssh \
   --host=$i 
	echo "$i"
done

#cmd kernell command can be nested 

#   --workdir='/home/me/Workdir'
#--name="Python 2.7" --cpus=2  - different python and cpus option

#remote_ikernel manage --add \
#   --kernel_cmd="/home/me/Virtualenvs/dev/bin/ipython kernel -f {connection_file}" \
#   --name="Python 2 (venv:dev)" --interface=local - for running locally any new kernels


jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token=''

tail -f /dev/null

