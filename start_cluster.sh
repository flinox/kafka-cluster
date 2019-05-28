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

# Create files if not exist
[ -f ./kafka/log/kafka1/server.log ] || touch ./kafka/log/kafka1/server.log
[ -f ./kafka/log/kafka2/server.log ] || touch ./kafka/log/kafka2/server.log
[ -f ./kafka/log/kafka3/server.log ] || touch ./kafka/log/kafka3/server.log

[ -f ./kafka/log/kafka1/state-change.log ] || touch ./kafka/log/kafka1/state-change.log
[ -f ./kafka/log/kafka2/state-change.log ] || touch ./kafka/log/kafka2/state-change.log
[ -f ./kafka/log/kafka3/state-change.log ] || touch ./kafka/log/kafka3/state-change.log

[ -f ./kafka/log/kafka1/kafka-request.log ] || touch ./kafka/log/kafka1/kafka-request.log
[ -f ./kafka/log/kafka2/kafka-request.log ] || touch ./kafka/log/kafka2/kafka-request.log
[ -f ./kafka/log/kafka3/kafka-request.log ] || touch ./kafka/log/kafka3/kafka-request.log

[ -f ./kafka/log/kafka1/log-cleaner.log ] || touch ./kafka/log/kafka1/log-cleaner.log
[ -f ./kafka/log/kafka2/log-cleaner.log ] || touch ./kafka/log/kafka2/log-cleaner.log
[ -f ./kafka/log/kafka3/log-cleaner.log ] || touch ./kafka/log/kafka3/log-cleaner.log

[ -f ./kafka/log/kafka1/controller.log ] || touch ./kafka/log/kafka1/controller.log
[ -f ./kafka/log/kafka2/controller.log ] || touch ./kafka/log/kafka2/controller.log
[ -f ./kafka/log/kafka3/controller.log ] || touch ./kafka/log/kafka3/controller.log

[ -f ./kafka/log/kafka1/kafka-authorizer.log ] || touch ./kafka/log/kafka1/kafka-authorizer.log
[ -f ./kafka/log/kafka2/kafka-authorizer.log ] || touch ./kafka/log/kafka2/kafka-authorizer.log
[ -f ./kafka/log/kafka3/kafka-authorizer.log ] || touch ./kafka/log/kafka3/kafka-authorizer.log


# Build changes if necessary
docker build -t flinox/zookeeper ./zookeeper/.
docker build -t flinox/kafka ./kafka/.
docker build -t flinox/kafka_client ./kafka_client/.
docker build -t flinox/kafka_monitoring ./kafka_monitoring/.

#export CURRENT_UID=$(id -u):$(id -g)
export COMPOSE_HTTP_TIMEOUT=30000

docker-compose up -d

docker-compose logs -f