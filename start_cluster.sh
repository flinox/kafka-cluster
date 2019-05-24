#!/bin/bash

# Create folders if not exist
[ -d ./zookeeper/data/zookeeper1 ] || mkdir -p ./zookeeper/data/zookeeper1
[ -d ./zookeeper/data/zookeeper2 ] || mkdir -p ./zookeeper/data/zookeeper2
[ -d ./zookeeper/data/zookeeper3 ] || mkdir -p ./zookeeper/data/zookeeper3

[ -d ./zookeeper/log/zookeeper1 ] || mkdir -p ./zookeeper/log/zookeeper1
[ -d ./zookeeper/log/zookeeper2 ] || mkdir -p ./zookeeper/log/zookeeper2
[ -d ./zookeeper/log/zookeeper3 ] || mkdir -p ./zookeeper/log/zookeeper3

[ -d ./kafka/log/kafka1/log ] || mkdir -p ./kafka/log/kafka1/log
[ -d ./kafka/log/kafka2/log ] || mkdir -p ./kafka/log/kafka2/log
[ -d ./kafka/log/kafka3/log ] || mkdir -p ./kafka/log/kafka3/log

[ -d ./kafka_monitoring/prometheus/data ] || mkdir -p ./kafka_monitoring/prometheus/data
[ -d ./kafka_monitoring/grafana/data ] || mkdir -p ./kafka_monitoring/grafana/data

# Build changes if necessary
docker build -t flinox/zookeeper ./zookeeper/.
docker build -t flinox/kafka ./kafka/.
docker build -t flinox/kafka_client ./kafka_client/.
docker build -t flinox/kafka_monitoring ./kafka_monitoring/.

#export CURRENT_UID=$(id -u):$(id -g)
export COMPOSE_HTTP_TIMEOUT=300

docker-compose up -d

docker-compose logs -f