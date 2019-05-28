#!/bin/bash

# BROKER SERVER
# Importar a chave publica do CA para o truststore
# entrada: ca-cert
# saida: server.truststore.jks 
keytool -keystore /opt/ssl/$HOSTNAME.truststore.jks -alias CARoot -import -file /opt/ssl/ca-cert -storepass $CLIENTPASSWORD -keypass $CLIENTPASSWORD -noprompt
# keytool -keystore /opt/ssl/$HOSTNAME.truststore.jks -alias CARoot -import -file /opt/ssl/kafka1/ca-cert -storepass $CLIENTPASSWORD -keypass $CLIENTPASSWORD -noprompt
# keytool -keystore /opt/ssl/$HOSTNAME.truststore.jks -alias CARoot2 -import -file /opt/ssl/kafka2/ca-cert -storepass $CLIENTPASSWORD -keypass $CLIENTPASSWORD -noprompt
# keytool -keystore /opt/ssl/$HOSTNAME.truststore.jks -alias CARoot3 -import -file /opt/ssl/kafka3/ca-cert -storepass $CLIENTPASSWORD -keypass $CLIENTPASSWORD -noprompt

