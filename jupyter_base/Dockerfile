FROM ubuntu_base AS base

#allow running ssh without password asking
#RUN sudo printf "Host hdfs-base\n\
#        Port 100001\n\
#Host hive\n\
#        Port 100002\n\
#Host spark\n\
#        Port 33\n\
#Host kafka\n\
#        Port 100004" >>  /etc/ssh/ssh_config

RUN mkdir src


RUN sudo apt-get update && apt-get install --no-install-recommends  -y build-essential python3.6 python3-pip python3-dev && \
    pip3 install remote_ikernel && \
    sudo apt clean && \
    sudo rm -rf /var/lib/apt/lists/*

RUN echo 'export PATH=$PATH:/home/root/.local/bin' >> ~/.bashrc && . ~/.bashrc

WORKDIR src/

RUN pip3 install jupyter && pip3 install virtualenv && mkdir tasks
RUN ln -sf /bin/bash /bin/sh

COPY bootstrap.sh ./

RUN chmod +x /src/bootstrap.sh 

ENTRYPOINT ["/src/bootstrap.sh"]
#expose Jupyter notebook default port
EXPOSE 8888


