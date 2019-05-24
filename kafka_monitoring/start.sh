#!/bin/bash

${PROMETHEUS_HOME}/prometheus-${PROMETHEUS_VERSION}.${ARCHITECTURE}/prometheus --config.file=${PROMETHEUS_HOME}/config/prometheus.yml --storage.tsdb.path=${PROMETHEUS_HOME}/data  & 

sleep 5

${GRAFANA_HOME}/bin/grafana-server


