#!/bin/bash

# 03 - CLIENT - importar o certificado assinado

# CLIENT 
# Importar a chave publica do CA para o truststore
# entrada: ca-cert
# saida: client.truststore.jks 
keytool -keystore /opt/ssl/$HOSTNAME.truststore.jks -alias CARoot -import -file /opt/ssl/ca-cert -storepass $CLIENTPASSWORD -keypass $CLIENTPASSWORD -noprompt


# CLIENT 
# Importar o certificado assinado e a chave publica do CA que assinou para a keystore
# entrada: ca-cert e cert-signed
# saida: client.keystore.jks updated
sleep 3
keytool -keystore /opt/ssl/$HOSTNAME.keystore.jks -alias CARoot -import -file /opt/ssl/ca-cert -storepass $CLIENTPASSWORD -keypass $CLIENTPASSWORD -noprompt

sleep 3
keytool -keystore /opt/ssl/$HOSTNAME.keystore.jks -alias $HOSTNAME -import -file /opt/ssl/cert-signed -storepass $CLIENTPASSWORD -keypass $CLIENTPASSWORD -noprompt

