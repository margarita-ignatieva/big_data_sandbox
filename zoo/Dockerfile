

# =============================================================================
# ========== Create ZOO
# =============================================================================
FROM ubuntu_base AS basy
#from here https://programmersought.com/article/47696299629/

RUN ln -sf /bin/bash /bin/sh 


RUN sudo apt-get update && \
    DEBIAN_FRONTEND=noninteractive \    
    sudo apt-get -y install --no-install-recommends wget && \
    sudo wget https://downloads.apache.org/zookeeper/zookeeper-3.8.0/apache-zookeeper-3.8.0-bin.tar.gz  && \
    sudo tar -zxvf apache-zookeeper-3.8.0-bin.tar.gz && sudo mv apache-zookeeper-3.8.0-bin /usr/local/zoo && \
    sudo rm apache-zookeeper-3.8.0-bin.tar.gz && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*  

RUN printf 'export ZOOKEEPER_HOME=/usr/local/zoo\n\
    export PATH=$PATH:$ZOOKEEPER_HOME/bin' >> ~/.bashrc
RUN . ~/.bashrc


# =============================================================================
# ========== Config ZOO
# =============================================================================

FROM basy

WORKDIR /usr/local/zoo

RUN sudo cp conf/zoo_sample.cfg conf/zoo.cfg && \
    sudo echo "server.1=zoo-base:2888:3888" >> conf/zoo.cfg && \
    sudo mkdir data && \
    echo '1' > data/myid    

COPY bootstrap.sh /usr/local/
RUN chmod +x /usr/local/bootstrap.sh

ENTRYPOINT ["/usr/local/bootstrap.sh"]


EXPOSE 2888 3888 2181
