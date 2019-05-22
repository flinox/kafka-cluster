#!/bin/bash

[ -d ./zookeeper/data/zookeeper1 ] || mkdir ./zookeeper/data/zookeeper1
[ -d ./zookeeper/data/zookeeper2 ] || mkdir ./zookeeper/data/zookeeper2
[ -d ./zookeeper/data/zookeeper3 ] || mkdir ./zookeeper/data/zookeeper3

[ -d ./zookeeper/log/zookeeper1 ] || mkdir ./zookeeper/log/zookeeper1
[ -d ./zookeeper/log/zookeeper2 ] || mkdir ./zookeeper/log/zookeeper2
[ -d ./zookeeper/log/zookeeper3 ] || mkdir ./zookeeper/log/zookeeper3

[ -d ./kafka/log/kafka1 ] || mkdir ./kafka/log/kafka1
[ -d ./kafka/log/kafka2 ] || mkdir ./kafka/log/kafka2
[ -d ./kafka/log/kafka3 ] || mkdir ./kafka/log/kafka3

export CURRENT_UID=$(id -u):$(id -g)

docker-compose up