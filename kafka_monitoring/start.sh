#!/bin/bash

${PROMETHEUS_HOME}/prometheus-${PROMETHEUS_VERSION}.${ARCHITECTURE}/prometheus --config.file=${PROMETHEUS_HOME}/config/prometheus.yml & 

sleep 5

${GRAFANA_HOME}/grafana-${GRAFANA_VERSION}/bin/grafana-server


