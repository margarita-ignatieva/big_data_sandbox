# =============================================================================
# ========== Create spark image
# =============================================================================
FROM  ubuntu_base AS spark_prep
#taken from here https://github.com/kristinjeanna/docker-ubuntu-jre8/blob/main/Dockerfile

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*


# =============================================================================
# ========== Download spark
# =============================================================================
ARG HADOOP_VERSION
ARG POSTGRESQL_CONNECTOR_VERSION

FROM spark_prep

WORKDIR /usr/local
ENV HADOOP_VERSION 3.3.1
ENV POSTGRESQL_CONNECTOR_VERSION 42.2.5

RUN sudo apt-get update && \
    DEBIAN_FRONTEND=noninteractive \    
    sudo apt-get -y install --no-install-recommends wget && \
    sudo wget https://downloads.apache.org/spark/spark-3.2.1/spark-3.2.1-bin-hadoop3.2.tgz && \
    sudo tar xvf spark-* && sudo mv spark-3.2.1-bin-hadoop3.2 /usr/local/spark && \
    sudo rm spark-3.2.1-bin-hadoop3.2.tgz  && \
    wget --no-check-certificate  https://repo1.maven.org/maven2/org/postgresql/postgresql/42.2.5/postgresql-42.2.5.jar && \
    mv postgresql-42.2.5.jar /usr/local/spark/jars && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*  

RUN printf 'export SPARK_HOME=/usr/local/spark\n\
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin\n\
export PYSPARK_PYTHON=/usr/bin/python3' >> ~/.bashrc && . ~/.bashrc 

COPY core-site.xml hdfs-site.xml hive-site.xml yarn-site.xml /usr/local/spark/conf/ 
COPY bootstrap.sh ./

RUN chmod +x /usr/local/bootstrap.sh 

RUN mv /usr/local/spark/conf/spark-env.sh.template /usr/local/spark/conf/spark-env.sh && \
    echo 'export HADOOP_CONF_DIR=/usr/local/spark/conf' >> /usr/local/spark/conf/spark-env.sh 

ENTRYPOINT ["/usr/local/bootstrap.sh"]

EXPOSE 8080 7077 33



