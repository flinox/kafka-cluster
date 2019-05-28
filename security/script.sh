#!/bin/bash

# Clear old files
echo ""
read -p "Todos os certificados serão apagados, Pressione uma tecla para continuar..."

rm -f ./kafka/ssl/kafka1/*
rm -f ./kafka/ssl/kafka2/*
rm -f ./kafka/ssl/kafka3/*

rm -f ./kafka_client/ssl/kafka_client.truststore.jks
rm -f ./kafka_client/ssl/kafka_client.keystore.jks
rm -f ./kafka_client/ssl/ca-cert
rm -f ./kafka_client/ssl/cert-file
rm -f ./kafka_client/ssl/cert-signed
rm -f ./kafka_client/ssl/kafka1/*
rm -f ./kafka_client/ssl/kafka2/*
rm -f ./kafka_client/ssl/kafka3/*

rm -f ./kafka_monitoring/ssl/kafka1/*
rm -f ./kafka_monitoring/ssl/kafka2/*
rm -f ./kafka_monitoring/ssl/kafka3/*
rm -f ./kafka_monitoring/ssl/client/*

echo ""
read -p "Gerar keystore e cert-file, Pressione uma tecla para continuar..."
docker exec -it kafka1 sh /opt/script/cert-01.sh

sleep 2
docker exec -it kafka2 sh /opt/script/cert-01.sh

sleep 2
docker exec -it kafka3 sh /opt/script/cert-01.sh

sleep 2
docker exec -it kafka_client bash /opt/ssl/script/cert-client-01.sh

echo ""
read -p "Envia cert-file to CA, Pressione uma tecla para continuar..."
cp ./kafka/ssl/kafka1/cert-file ./kafka_monitoring/ssl/kafka1/
cp ./kafka/ssl/kafka2/cert-file ./kafka_monitoring/ssl/kafka2/
cp ./kafka/ssl/kafka3/cert-file ./kafka_monitoring/ssl/kafka3/
cp ./kafka_client/ssl/cert-file ./kafka_monitoring/ssl/client/

echo ""
read -p "Assina o cert-file para gerar o cert-signed, Pressione uma tecla para continuar..."
docker exec -it kafka_monitoring bash /opt/ssl/script/cert-02.sh

echo ""
read -p "Envia cert-signed do CA para os brokers, Pressione uma tecla para continuar..."
cp ./kafka_monitoring/ssl/kafka1/cert-signed ./kafka/ssl/kafka1/
cp ./kafka_monitoring/ssl/kafka2/cert-signed ./kafka/ssl/kafka2/
cp ./kafka_monitoring/ssl/kafka3/cert-signed ./kafka/ssl/kafka3/
cp ./kafka_monitoring/ssl/client/cert-signed ./kafka_client/ssl/

cp ./kafka_monitoring/ssl/kafka1/cert-signed ./kafka_client/ssl/kafka1/
cp ./kafka_monitoring/ssl/kafka2/cert-signed ./kafka_client/ssl/kafka2/
cp ./kafka_monitoring/ssl/kafka3/cert-signed ./kafka_client/ssl/kafka3/

echo ""
read -p "Envia ca-cert chave pública do CA que assinou para os brokers, Pressione uma tecla para continuar..."
cp ./kafka_monitoring/ssl/ca/ca-cert ./kafka/ssl/kafka1/
cp ./kafka_monitoring/ssl/ca/ca-cert ./kafka/ssl/kafka2/
cp ./kafka_monitoring/ssl/ca/ca-cert ./kafka/ssl/kafka3/
cp ./kafka_monitoring/ssl/ca/ca-cert ./kafka_client/ssl/

echo ""
read -p "Importa cert-signed para keystore e gera truststore, Pressione uma tecla para continuar..."
docker exec -it kafka1 sh /opt/script/cert-03.sh

sleep 2
docker exec -it kafka2 sh /opt/script/cert-03.sh

sleep 2
docker exec -it kafka3 sh /opt/script/cert-03.sh

sleep 2
docker exec -it kafka_client bash /opt/ssl/script/cert-client-03.sh

echo "Fim."
