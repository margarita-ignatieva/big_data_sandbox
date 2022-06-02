# =============================================================================
# ========== Create hdfs image
# =============================================================================
FROM ubuntu_base AS base

WORKDIR /usr/local
ENV HADOOP_VERSION 3.3.1

RUN sudo apt-get update && sudo apt-get install --no-install-recommends -y wget && \
    sudo wget --no-check-certificate  https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    sudo tar zxvf hadoop-${HADOOP_VERSION}.tar.gz &&  sudo rm hadoop-${HADOOP_VERSION}.tar.gz && \
    sudo mv hadoop-${HADOOP_VERSION} hadoop && \
    sudo chmod -R 777 /usr/local/hadoop && \
    sudo chmod 0600 ~/.ssh/authorized_keys && \
    sudo chmod 700 ~/.ssh && chmod 600 ~/.ssh/* && \
    sudo apt clean && \
    sudo rm -rf /var/lib/apt/lists/*

#adding hadoop and java environment variable
#todo add new variables with a sh script
# this added to one run command
# not sure we need them so much
RUN printf 'export HADOOP_VERSION=3.3.1\n\ 
export HDFS_USER=root\n\ 
export HADOOP_HOME=/usr/local/hadoop\n\ 
export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop\n\ 
export HADOOP_MAPRED_HOME=/usr/local/hadoop\n\ 
export HADOOP_COMMON_HOME=/usr/local/hadoop\n\ 
export HADOOP_HDFS_HOME=/usr/local/hadoop\n\ 
export YARN_HOME=/usr/local/hadoop\n\ 
export PATH=$PATH:/usr/local/hadoop/bin\n\ 
export PATH=$PATH:/usr/local/hadoop/sbin\n\ 
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native\n\ 
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"\n\ 
export HDFS_NAMENODE_USER=root\n\ 
export HDFS_DATANODE_USER=root\n\ 
export HDFS_SECONDARYNAMENODE_USER=root\n\ 
export YARN_RESOURCEMANAGER_USER=root\n\ 
export YARN_NODEMANAGER_USER=root' >> ~/.bashrc && . ~/.bashrc

RUN printf 'export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true\n\
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64\n\
export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true -Djava.security.krb5.realm= -Djava.security.krb5.kdc="\n\
export HADOOP_HOME_WARN_SUPPRESS="TRUE"\n\ 
export HDFS_USER=root\n\
export HDFS_NAMENODE_USER=root\n\
export HDFS_DATANODE_USER=root\n\
export HDFS_SECONDARYNAMENODE_USER=root\n\
export YARN_RESOURCEMANAGER_USER=root\n\
export YARN_NODEMANAGER_USER=root' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh

#copy config files and startup file to destination
#TODO - implement sh script to update those values like here
# https://github.com/Marcel-Jan/docker-hadoop-spark/blob/master/base/entrypoint.sh
#add proxy users to core sites  as from here https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/admin_hdfs_proxy_users.html#:~:text=Hadoop%20allows%20you%20to%20configure%20proxy%20users%20to,than%20those%20of%20a%20superuser%20%28such%20as%20hdfs%29.
COPY core-site.xml /usr/local/hadoop/etc/hadoop/
COPY hdfs-site.xml /usr/local/hadoop/etc/hadoop/
COPY yarn-site.xml /usr/local/hadoop/etc/hadoop/
COPY mapred-site.xml /usr/local/hadoop/etc/hadoop/
COPY bootstrap.sh /usr/local/
RUN chmod +x /usr/local/bootstrap.sh
RUN mkdir -p /usr/local/hadoop/data/dfs/namenode
RUN mkdir -p /usr/local/hadoop/data/dfs/datanode
VOLUME /usr/local/hadoop/data/dfs/datanode
VOLUME /usr/local/hadoop/data/dfs/namenode


ENTRYPOINT ["/usr/local/bootstrap.sh"]

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000 9870
# Mapred ports
EXPOSE 10020 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 2122 22 8899



