
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

RUN apt-get update && apt-get install -y apt-utils wget sed

# Install prometheus server
RUN mkdir -p ${PROMETHEUS_HOME} \
    && wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.${ARCHITECTURE}.tar.gz -P ${PROMETHEUS_HOME}
RUN tar -C ${PROMETHEUS_HOME} -xzvf ${PROMETHEUS_HOME}/prometheus-${PROMETHEUS_VERSION}.${ARCHITECTURE}.tar.gz && rm ${PROMETHEUS_HOME}/prometheus-${PROMETHEUS_VERSION}.${ARCHITECTURE}.tar.gz \
    && mkdir -p ${PROMETHEUS_HOME}/config && mkdir -p ${PROMETHEUS_HOME}/data

COPY ./prometheus/config/prometheus.yml ${PROMETHEUS_HOME}/config

# Install grafana
RUN mkdir -p ${GRAFANA_HOME} && mkdir -p ${GRAFANA_HOME}/data \
    && wget https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.${ARCHITECTURE}.tar.gz -P ${GRAFANA_HOME}
RUN tar -C ${GRAFANA_HOME} -zxvf ${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}.${ARCHITECTURE}.tar.gz && rm ${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}.${ARCHITECTURE}.tar.gz \
    && mv ${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}/* ${GRAFANA_HOME} \
    && cd ${GRAFANA_HOME} && rm ./grafana-${GRAFANA_VERSION} -R

COPY ./grafana/conf/defaults.ini ${GRAFANA_HOME}/conf

# Copying files
COPY start.sh ${GRAFANA_HOME}

WORKDIR ${GRAFANA_HOME}

EXPOSE 9090
EXPOSE 3000

CMD sh -c "./start.sh"