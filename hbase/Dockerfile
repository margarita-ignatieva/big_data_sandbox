FROM ubuntu_base

WORKDIR /usr/local

RUN sudo apt-get update && \
    DEBIAN_FRONTEND=noninteractive && \    
    sudo apt-get -y install --no-install-recommends wget && \
    sudo wget https://archive.apache.org/dist/hbase/stable/hbase-2.4.12-bin.tar.gz  && \
    sudo tar -zxvf hbase-2.4.12-bin.tar.gz  && sudo mv hbase-2.4.12 /usr/local/hbase && \
    sudo rm hbase-2.4.12-bin.tar.gz  && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*  

RUN printf 'export HBASE_HOME=/usr/local/hbase\n\
export PATH=$PATH:$HBASE_HOME/bin' >> ~/.bashrc
RUN . ~/.bashrc

RUN printf 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64\n\
export HBASE_MANAGES_ZK=false' >> /usr/local/hbase/conf/hbase-env.sh

COPY bootstrap.sh /usr/local/
COPY hbase-site.xml /usr/local/hbase/conf/

RUN chmod +x /usr/local/bootstrap.sh

ENTRYPOINT ["/usr/local/bootstrap.sh"]

EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030
# HBase Rest server
EXPOSE 8070
# HBase Rest server web UI
EXPOSE 8090
