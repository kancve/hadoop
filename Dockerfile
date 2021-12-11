ARG VERSION=latest

FROM ubuntu:${VERSION}

LABEL author="kancve<https://kancve.github.io/>"

# install hadoop runtime environment
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
    wget \
    openjdk-8-jdk-headless && \
    rm -rf /var/lib/apt/lists/*

ARG HADOOP_VERSION=3.2.2

# install hadoop
RUN cd /opt && \
    wget https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -zxvf hadoop-${HADOOP_VERSION}.tar.gz && \
    rm -rf hadoop-${HADOOP_VERSION}.tar.gz hadoop-${HADOOP_VERSION}/share/doc

# set environment variable for java & hadoop
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION} LANG=C.UTF-8
ENV PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
