FROM goffity/ubuntu:18.04

LABEL maintainer="Goffity Corleone"

ENV ZOOKEEPER_VERSION 3.6.1
ENV ZK_HOME /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin

# RUN apk add --no-cache bash

RUN wget -q https://downloads.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz
# RUN wget -q https://www.apache.org/dist/zookeeper/KEYS
# RUN wget -q https://www.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz.asc
# RUN wget -q https://www.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz.md5

RUN ls -alh
RUN tar -xzf apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz -C /opt

RUN mv /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin/conf/zoo_sample.cfg /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin/conf/zoo.cfg

RUN sed  -i "s|/tmp/zookeeper|$ZK_HOME/data|g" $ZK_HOME/conf/zoo.cfg; mkdir $ZK_HOME/data

ADD start-zk.sh /usr/bin/start-zk.sh 
EXPOSE 2181 2888 3888

WORKDIR /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin
VOLUME ["/opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin/conf", "/opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin/data"]

CMD /usr/sbin/sshd && bash /usr/bin/start-zk.sh
# CMD ["/bin/bash"]