FROM ubuntu:bionic AS base

RUN apt-get update -y && \
    apt-get install --no-install-recommends sudo -y && \
    apt-get install --no-install-recommends nano -y && \
    apt-get install --no-install-recommends openssh-server openssh-client -y && \
    rm -rf /var/lib/apt/lists/*

#allow running ssh without password asking
RUN sudo echo -e "Host *\nStrictHostKeyChecking no\nUserKnownHostsFile=/dev/null" >>  /etc/ssh/ssh_config
#disable ipv6 -- needed for hadoop
RUN sudo echo -e 'net.ipv6.conf.all.disable_ipv6=1\nnet.ipv6.conf.default_ipv6=1\nnet.ipv6.conf.lo.disable_ipv6=1' >> /etc/sysctl.conf

RUN mkdir ~/.ssh
# =============================================================================
# ========== Create SSH keys
# =============================================================================
FROM ubuntu:bionic AS ssh_keys

RUN mkdir keys && apt-get update -y && apt-get install --no-install-recommends openssh-server -y

#add hdfs user to hadoop group with root privilages
RUN  ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
     cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
     chmod 0600 ~/.ssh/authorized_keys && \
     chmod +x ~/.ssh
RUN cp -r ~/.ssh/* /keys

# =============================================================================
# ========== Download scala and jre
# =============================================================================
FROM base AS ubuntu_base

# copy keys to ssh
COPY --from=ssh_keys /keys/*  /root/.ssh/

RUN ln -sf /bin/bash /bin/sh

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -y install --no-install-recommends  openjdk-8-jre-headless ca-certificates-java && \
    sudo apt-get -y install --no-install-recommends python3.8   && \
    sudo apt-get -y install --no-install-recommends python3-pip && \
    sudo apt-get -y install --no-install-recommends python3-dev default-libmysqlclient-dev build-essential && \
    pip3 install ipykernel  && \
    pip3 install ipython && \
    apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# add script to alter xml
RUN printf 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64\n\ 
export PATH=$PATH:$JAVA_HOME/bin\n\' >> ~/.bashrc && . ~/.bashrc 

COPY ./scripts /usr/local/













