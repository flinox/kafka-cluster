#!/bin/bash

[ -d ./zookeeper/data/zookeeper1 ] || mkdir -p ./zookeeper/data/zookeeper1
[ -d ./zookeeper/data/zookeeper2 ] || mkdir -p ./zookeeper/data/zookeeper2
[ -d ./zookeeper/data/zookeeper3 ] || mkdir -p ./zookeeper/data/zookeeper3

[ -d ./zookeeper/log/zookeeper1 ] || mkdir -p ./zookeeper/log/zookeeper1
[ -d ./zookeeper/log/zookeeper2 ] || mkdir -p ./zookeeper/log/zookeeper2
[ -d ./zookeeper/log/zookeeper3 ] || mkdir -p ./zookeeper/log/zookeeper3

[ -d ./kafka/log/kafka1 ] || mkdir -p ./kafka/log/kafka1
[ -d ./kafka/log/kafka2 ] || mkdir -p ./kafka/log/kafka2
[ -d ./kafka/log/kafka3 ] || mkdir -p ./kafka/log/kafka3

export CURRENT_UID=$(id -u):$(id -g)
export COMPOSE_HTTP_TIMEOUT=200

docker-compose up