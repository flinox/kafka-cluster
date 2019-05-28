#!/bin/bash

# Build changes if necessary
docker build -t flinox/zookeeper ./zookeeper/.
docker build -t flinox/kafka ./kafka/.
docker build -t flinox/kafka_client ./kafka_client/.
docker build -t flinox/kafka_monitoring ./kafka_monitoring/.
