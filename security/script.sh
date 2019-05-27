#!/bin/bash

echo "Generate keystore e cert-file..."
read -p "Pressione uma tecla para continuar..."
docker exec -it kafka1 sh /opt/script/cert-01.sh

sleep 2
docker exec -it kafka2 sh /opt/script/cert-01.sh

sleep 2
docker exec -it kafka3 sh /opt/script/cert-01.sh

echo "Envia cert-file to CA..."
read -p "Pressione uma tecla para continuar..."
cp ../kafka/ssl/kafka1/cert-file ../kafka_monitoring/ssl/kafka1/
cp ../kafka/ssl/kafka2/cert-file ../kafka_monitoring/ssl/kafka2/
cp ../kafka/ssl/kafka3/cert-file ../kafka_monitoring/ssl/kafka3/

echo "Assina o cert-file para gerar o cert-signed..."
read -p "Pressione uma tecla para continuar..."
docker exec -it kafka_monitoring bash /opt/ssl/cert-02.sh

echo "Envia cert-signed do CA para os brokers..."
read -p "Pressione uma tecla para continuar..."
cp ../kafka_monitoring/ssl/kafka1/cert-signed ../kafka/ssl/kafka1/
cp ../kafka_monitoring/ssl/kafka2/cert-signed ../kafka/ssl/kafka2/
cp ../kafka_monitoring/ssl/kafka3/cert-signed ../kafka/ssl/kafka3/

echo "Importa cert-signed para keystore e gera truststore..."
read -p "Pressione uma tecla para continuar..."
docker exec -it kafka1 sh /opt/script/cert-03.sh

sleep 2
docker exec -it kafka2 sh /opt/script/cert-03.sh

sleep 2
docker exec -it kafka3 sh /opt/script/cert-03.sh

echo "Testar secutiry..."
read -p "Pressione uma tecla para continuar..."
docker exec -it kafka_monitoring bash -c "openssl s_client -debug -connect kafka1:9093 -tls1"

echo "Fim."
