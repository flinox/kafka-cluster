
FROM ubuntu:latest

ARG PRV=2.9.2
ARG PRA=linux-amd64

ENV PROMETHEUS_VERSION=${PRV}
ENV PROMETHEUS_ARCH=${PRA}
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y apt-utils wget

#RUN apt-get install -y net-tools netcat curl wget apt-transport-https telnet

#RUN apt-get install -y git nano python3 jq gnupg2 zip unzip sqlite3 libsqlite3-dev

#RUN apt-get install -y default-jre default-jdk

#RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

#RUN wget -qO - http://packages.confluent.io/deb/3.1/archive.key | apt-key add - && echo "deb [arch=amd64] http://packages.confluent.io/deb/3.1 stable main" | tee -a /etc/apt/sources.list.d/confluent.list

#RUN apt-get update && apt-get install -y kubectl kafkacat confluent-platform-oss-2.11

#RUN wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz -P /tmp/ && tar -C /usr/local -xzf /tmp/go1.12.5.linux-amd64.tar.gz && go version

RUN mkdir -p /opt/prometheus && wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.${PROMETHEUS_ARCH}.tar.gz -P /opt/prometheus \
    && tar -C /opt/prometheus -xzf /opt/prometheus/prometheus-${PROMETHEUS_VERSION}.${PROMETHEUS_ARCH}.tar.gz && rm /opt/prometheus/prometheus-${PROMETHEUS_VERSION}.${PROMETHEUS_ARCH}.tar.gz \
    && mkdir -p /opt/prometheus/config

COPY ./prometheus/* /opt/prometheus/config

WORKDIR /opt/prometheus/prometheus-${PROMETHEUS_VERSION}.${PROMETHEUS_ARCH}

EXPOSE 9090
