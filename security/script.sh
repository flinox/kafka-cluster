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

echo "Envia ca-cert chave pública do CA que assinou para os brokers..."
read -p "Pressione uma tecla para continuar..."
cp ../kafka_monitoring/ssl/ca-cert ../kafka/ssl/kafka1/
cp ../kafka_monitoring/ssl/ca-cert ../kafka/ssl/kafka2/
cp ../kafka_monitoring/ssl/ca-cert ../kafka/ssl/kafka3/

echo "Importa cert-signed para keystore e gera truststore..."
read -p "Pressione uma tecla para continuar..."
docker exec -it kafka1 sh /opt/script/cert-03.sh

sleep 2
docker exec -it kafka2 sh /opt/script/cert-03.sh

sleep 2
docker exec -it kafka3 sh /opt/script/cert-03.sh


echo "Copiar os ca-cert dos broker para os clients..."
read -p "Pressione uma tecla para continuar..."
cp ../kafka/ssl/kafka1/ca-cert ../kafka_client/ssl/kafka1/
cp ../kafka/ssl/kafka2/ca-cert ../kafka_client/ssl/kafka2/
cp ../kafka/ssl/kafka3/ca-cert ../kafka_client/ssl/kafka3/

cp ../kafka/ssl/kafka1/ca-cert ../kafka_monitoring/ssl/kafka1/
cp ../kafka/ssl/kafka2/ca-cert ../kafka_monitoring/ssl/kafka2/
cp ../kafka/ssl/kafka3/ca-cert ../kafka_monitoring/ssl/kafka3/

sleep 2
docker exec -it kafka_client sh /opt/ssl/script/cert-client.sh

#echo "Check the content of keystore"
#docker exec -it kafka_client sh "keytool -list -v -keystore /opt/ssl/kafka_client.truststore.jks"

echo "Testar secutiry..."
read -p "Pressione uma tecla para continuar..."
docker exec -it kafka_monitoring bash -c "openssl s_client -debug -connect kafka1:9093 -msg -cipher 'SHA1'"

echo "Fim."
