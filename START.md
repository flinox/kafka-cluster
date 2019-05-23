
# Pré-requisitos

- Docker installed - https://docs.docker.com/v17.12/install


# Build images zookeeper

## Zookeeper
```
docker build -t flinox/zookeeper ./zookeeper/.
```

## Kafka
```
docker build -t flinox/kafka ./kafka/.
```

## Kafka Client
```
docker build -t flinox/kafka_client ./kafka_client/.
```

## Rebuild all images

```
docker build -t flinox/zookeeper ./zookeeper/.
docker build -t flinox/kafka ./kafka/.
docker build -t flinox/kafka_client ./kafka_client/.
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