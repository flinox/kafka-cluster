## KAFKA_MONITORING ##

FROM ubuntu:latest

ARG PRV=2.24.0
ARG GRV=7.3.6
ARG SSL=1.1.1b
ARG ARC=linux-amd64
ARG PRH=/opt/prometheus
ARG GRH=/opt/grafana
    
ENV PROMETHEUS_VERSION=${PRV} \
    PROMETHEUS_HOME=${PRH} \  
    ARCHITECTURE=${ARC} \
    GRAFANA_HOME=${GRH} \
    GRAFANA_VERSION=${GRV} \
    OPENSSL_VERSION=${SSL} \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y apt-utils wget sed net-tools netcat default-jre default-jdk tzdata

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && echo "America/Sao_Paulo" >  /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# Install prometheus server
RUN mkdir -p ${PROMETHEUS_HOME} && \
    wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.${ARCHITECTURE}.tar.gz -P ${PROMETHEUS_HOME}

RUN tar -C ${PROMETHEUS_HOME} -xzvf ${PROMETHEUS_HOME}/prometheus-${PROMETHEUS_VERSION}.${ARCHITECTURE}.tar.gz && rm ${PROMETHEUS_HOME}/prometheus-${PROMETHEUS_VERSION}.${ARCHITECTURE}.tar.gz && \
    mkdir -p ${PROMETHEUS_HOME}/config && mkdir -p ${PROMETHEUS_HOME}/data

COPY ./prometheus/config/prometheus.yml ${PROMETHEUS_HOME}/config

# Install grafana
RUN mkdir -p ${GRAFANA_HOME} && mkdir -p ${GRAFANA_HOME}/data && \
    wget https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.${ARCHITECTURE}.tar.gz -P ${GRAFANA_HOME}

RUN tar -C ${GRAFANA_HOME} -zxvf ${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}.${ARCHITECTURE}.tar.gz && rm ${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}.${ARCHITECTURE}.tar.gz 

RUN mv ${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}/* ${GRAFANA_HOME} && \
    cd ${GRAFANA_HOME} && rm ./grafana-${GRAFANA_VERSION} -R

# Install openssl
RUN apt-get install -y perl make gcc ca-certificates iputils-ping openssh-server && \
    wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz -P /tmp && tar -xzvf /tmp/openssl-${OPENSSL_VERSION}.tar.gz -C /tmp

RUN cd /tmp/openssl-${OPENSSL_VERSION} && mv /usr/bin/openssl /tmp/openssl_old && ./config && make install && \
    ln -s /usr/local/bin/openssl /usr/bin/openssl && ldconfig && openssl version

COPY ./grafana/conf/defaults.ini ${GRAFANA_HOME}/conf

# Copying files
COPY start.sh ${GRAFANA_HOME}

WORKDIR ${GRAFANA_HOME}

EXPOSE 9090
EXPOSE 3000

CMD sh -c "./start.sh"
