#!/bin/sh

# 03 - BROKERS - importar o certificado assinado

# BROKER SERVER
# Importar a chave publica do CA para o truststore
# entrada: ca-cert
# saida: server.truststore.jks 
keytool -keystore /opt/ssl/$HOSTNAME.truststore.jks -alias CARoot -import -file /opt/ssl/ca-cert -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -noprompt


# BROKER SERVER
# Importar o certificado assinado e a chave publica do CA que assinou para a keystore
# entrada: ca-cert e cert-signed
# saida: server.keystore.jks updated
sleep 3
keytool -keystore /opt/ssl/$HOSTNAME.keystore.jks -alias CARoot -import -file /opt/ssl/ca-cert -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -noprompt

# localhost
sleep 3
keytool -keystore /opt/ssl/$HOSTNAME.keystore.jks -alias $HOSTNAME -import -file /opt/ssl/cert-signed -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -noprompt


