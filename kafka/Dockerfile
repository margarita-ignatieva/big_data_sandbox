
# =============================================================================
# ========== Create KAFKA user 
# =============================================================================
FROM ubuntu_base AS base

#from hereeeeeeeeeeeee  https://github.com/wurstmeister/kafka-docker/blob/master/Dockerfile
#and here zoooookeeeper  https://github.com/wurstmeister/zookeeper-docker



#taken from here https://github.com/kristinjeanna/docker-ubuntu-jre8/blob/main/Dockerfile


RUN apt-get update && \ 
    apt-get -y install --no-install-recommends scala && \
    apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

##from here we just need copy scala and jre dirs

# =============================================================================
# ========== Download kafka
# =============================================================================

FROM base

WORKDIR /usr/local

RUN sudo apt-get update && \
    DEBIAN_FRONTEND=noninteractive && \    
    sudo apt-get -y install --no-install-recommends wget && \
    sudo wget https://archive.apache.org/dist/kafka/3.2.0/kafka_2.12-3.2.0.tgz  && \
    sudo tar -zxvf kafka_2.12-3.2.0.tgz && sudo mv kafka_2.12-3.2.0 /usr/local/kafka && \
    sudo rm kafka_2.12-3.2.0.tgz && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*  

RUN printf 'export SCALA=/usr/share/scala-2.11\n\ 
export PATH=$PATH:$SCALA/bin\n\ ' >> ~/.bashrc && . ~/.bashrc 


EXPOSE 9092



