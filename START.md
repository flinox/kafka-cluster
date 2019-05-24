
# Pré-requisitos

- Docker installed - https://docs.docker.com/v17.12/install



# Docker images

## Rebuild all images, zookeeper, kafka, kafka_client e kafka_monitoring

```
docker build -t flinox/zookeeper ./zookeeper/.
docker build -t flinox/kafka ./kafka/.
docker build -t flinox/kafka_client ./kafka_client/.
docker build -t flinox/kafka_monitoring ./kafka_monitoring/.
```

# Inicializar o cluster

```
./start_cluster.sh
```




------------
## Código de apoio (temporario)

# Execucao individual

## Zookeeper
```
export ID=1
docker run --rm \
--name zookeeper${ID} --hostname zookeeper${ID} \
--network bridge \
-u 1000:1000 -e ID=${ID} \
-v $(pwd)/zookeeper/data/zookeeper${ID}/:/data/zookeeper \
-v $(pwd)/zookeeper/log/zookeeper${ID}/:/opt/zookeeper/log \
-v $(pwd)/zookeeper/conf/:/opt/zookeeper/conf \
flinox/zookeeper
```

- Informe o ID para identificacao unica do nó do cluster

## Kafka

```
export ID=1

docker run --rm \
--name kafka${ID} --hostname kafka${ID} \
--network bridge \
-u 1000:1000 -e ID=${ID} \
-v $(pwd)/log/kafka${ID}/:/opt/kafka/log \
-v $(pwd)/config/kafka${ID}:/opt/kafka/config \
flinox/kafka
```

- Informe o ID para identificacao unica do nó do cluster



# Metricas

## Prometheus

Para acessar o prometheus e consultar as metricas ou executar alguma consulta, acesse:
[http://localhost:9090](http://localhost:9090)
![Prometheus](/plano/images/2019-05-23-prometheus-01.png)

## Grafana

Para acessar o grafana e ter acesso ao dashboard, acesse:
[http://localhost:3000](http://localhost:3000)
![Grafana](/plano/images/2019-05-23-grafana-01.png)



## Todas as metricas kafka para monitorar
https://kafka.apache.org/documentation/#monitoring

