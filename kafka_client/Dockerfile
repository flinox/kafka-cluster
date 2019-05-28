## KAFKA_CLIENT ##

FROM ubuntu:latest

ARG SSL=1.1.1b

ENV DEBIAN_FRONTEND noninteractive
ENV GOPATH /go
ENV PATH ${PATH}:${GOPATH}/bin:/usr/local/go/bin
ENV OPENSSL_VERSION=${SSL}

RUN apt-get update && apt-get install -y apt-utils tzdata make gcc

RUN apt-get install -y openjdk-8-jre

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && echo "America/Sao_Paulo" >  /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install -y net-tools netcat curl wget apt-transport-https telnet

RUN apt-get install -y git nano python3 jq gnupg2 zip unzip sqlite3 libsqlite3-dev

#RUN apt-get install -y default-jre default-jdk make gcc

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

RUN wget -qO - http://packages.confluent.io/deb/3.1/archive.key | apt-key add - && echo "deb [arch=amd64] http://packages.confluent.io/deb/3.1 stable main" | tee -a /etc/apt/sources.list.d/confluent.list

RUN apt-get update && apt-get install -y kubectl kafkacat confluent-platform-oss-2.11

RUN wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz -P /tmp/ && tar -C /usr/local -xzf /tmp/go1.12.5.linux-amd64.tar.gz && go version

RUN go get -v github.com/Shopify/sarama

RUN go get -v github.com/wvanbergen/kafka/consumergroup

RUN mkdir -p /go/src/app_producer && mkdir -p /go/src/app_consumer

# Install openssl
RUN apt-get install -y perl make gcc \
    && wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz -P /tmp && tar -xzvf /tmp/openssl-${OPENSSL_VERSION}.tar.gz -C /tmp

RUN cd /tmp/openssl-${OPENSSL_VERSION} && mv /usr/bin/openssl /tmp/openssl_old && ./config && make install \
    && ln -s /usr/local/bin/openssl /usr/bin/openssl && ldconfig && openssl version

# Install certificate CA private
RUN apt-get install -y ca-certificates iputils-ping openssh-server
# COPY ./ssl/CA/ca-cert /usr/share/ca-certificates/
# RUN chmod 644 /usr/share/ca-certificates/ca-cert && update-ca-certificates

WORKDIR /go


