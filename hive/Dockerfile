FROM hadoop-base

#according to https://phoenixnap.com/kb/install-hive-on-ubuntu
ARG POSTGRESQL_CONNECTOR_VERSION=42.2.5
ENV HIVE_VERSION 3.1.2

#todo rename to short hive folder with mv command
RUN sudo wget --no-check-certificate  https://downloads.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    sudo tar xzf apache-hive-${HIVE_VERSION}-bin.tar.gz && sudo mv /usr/local/apache-hive-${HIVE_VERSION}-bin /usr/local/hive && \
 rm apache-hive-${HIVE_VERSION}-bin.tar.gz 

ENV HIVE_HOME /usr/local/hive

RUN wget --no-check-certificate  https://repo1.maven.org/maven2/org/postgresql/postgresql/${POSTGRESQL_CONNECTOR_VERSION}/postgresql-${POSTGRESQL_CONNECTOR_VERSION}.jar 
RUN mv postgresql-${POSTGRESQL_CONNECTOR_VERSION}.jar /usr/local/hive/lib

RUN echo 'export HIVE_HOME=/usr/local/hive' >> ~/.bashrc
RUN echo 'export PATH=$PATH:$HIVE_HOME/bin' >> ~/.bashrc
RUN . ~/.bashrc

RUN chmod +x ${HIVE_HOME}/bin/hive-config.sh
RUN echo 'export HADOOP_HOME=/usr/local/hadoop' >>  $HIVE_HOME/bin/hive-config.sh

ADD hive-site.xml $HIVE_HOME/conf
COPY bootstrap.sh /usr/local/
RUN chmod +x /usr/local/bootstrap.sh

WORKDIR /usr/local/hive

ENTRYPOINT ["/usr/local/bootstrap.sh"]

EXPOSE 9083
EXPOSE 10000
EXPOSE 10002

