
FROM ubuntu:latest

ARG PRV=2.9.2
ARG GRV=6.2.0
ARG ARC=linux-amd64
ARG PRH=/opt/prometheus
ARG GRH=/opt/grafana
    
ENV PROMETHEUS_VERSION=${PRV} \
    PROMETHEUS_HOME=${PRH} \  
    ARCHITECTURE=${ARC} \
    GRAFANA_HOME=${GRH} \
    GRAFANA_VERSION=${GRV}
#ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y apt-utils wget sed

#RUN apt-get install -y net-tools netcat curl wget apt-transport-https telnet

#RUN apt-get install -y git nano python3 jq gnupg2 zip unzip sqlite3 libsqlite3-dev

#RUN apt-get install -y default-jre default-jdk

#RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

#RUN wget -qO - http://packages.confluent.io/deb/3.1/archive.key | apt-key add - && echo "deb [arch=amd64] http://packages.confluent.io/deb/3.1 stable main" | tee -a /etc/apt/sources.list.d/confluent.list

#RUN apt-get update && apt-get install -y kubectl kafkacat confluent-platform-oss-2.11

#RUN wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz -P /tmp/ && tar -C /usr/local -xzf /tmp/go1.12.5.linux-amd64.tar.gz && go version

# Install prometheus server
RUN mkdir -p ${PROMETHEUS_HOME} \
    && wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.${ARCHITECTURE}.tar.gz -P ${PROMETHEUS_HOME} \
    && tar -C ${PROMETHEUS_HOME} -xzvf ${PROMETHEUS_HOME}/prometheus-${PROMETHEUS_VERSION}.${ARCHITECTURE}.tar.gz && rm ${PROMETHEUS_HOME}/prometheus-${PROMETHEUS_VERSION}.${ARCHITECTURE}.tar.gz \
    && mkdir -p ${PROMETHEUS_HOME}/config

COPY ./prometheus/prometheus.yml ${PROMETHEUS_HOME}/config

# Install grafana
RUN mkdir -p ${GRAFANA_HOME} \
    && wget https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.${ARCHITECTURE}.tar.gz -P ${GRAFANA_HOME} \
    && tar -C ${GRAFANA_HOME} -zxvf ${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}.${ARCHITECTURE}.tar.gz && rm ${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}.${ARCHITECTURE}.tar.gz

COPY ./grafana/defaults.ini ${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}/conf

# Copying files
COPY start.sh ${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}

WORKDIR ${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}

EXPOSE 9090
EXPOSE 3000

CMD sh -c "./start.sh"
#CMD sh -c "/opt/prometheus/prometheus-${PROMETHEUS_VERSION}.${ARCHITECTURE}/prometheus --config.file=${PROMETHEUS_HOME}/config/prometheus.yml & ${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}/bin/grafana-server"
