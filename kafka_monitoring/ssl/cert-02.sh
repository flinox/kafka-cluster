#!/bin/bash

# CA SERVER
# Assinar o certificados do broker
# entrada: cert-file
# saida: cert-signed
sleep 3
openssl x509 -req -CA ca-cert -CAkey ca-key -in /opt/ssl/kafka1/cert-file -out /opt/ssl/kafka1/cert-signed -days 365 -CAcreateserial -passin pass:$CAPASSWORD
mv /opt/ssl/ca-cert.srl /opt/ssl/kafka1/

sleep 3
openssl x509 -req -CA ca-cert -CAkey ca-key -in /opt/ssl/kafka2/cert-file -out /opt/ssl/kafka2/cert-signed -days 365 -CAcreateserial -passin pass:$CAPASSWORD
mv /opt/ssl/ca-cert.srl /opt/ssl/kafka2/

sleep 3
openssl x509 -req -CA ca-cert -CAkey ca-key -in /opt/ssl/kafka3/cert-file -out /opt/ssl/kafka3/cert-signed -days 365 -CAcreateserial -passin pass:$CAPASSWORD
mv /opt/ssl/ca-cert.srl /opt/ssl/kafka3/

# Enviar os cert-signed para os seus respectivos workers

