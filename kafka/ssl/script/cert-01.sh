#!/bin/sh

# 01 - BROKER - gera o request

# BROKER SERVER
# Gerar um certificado x509 para cada kafka broker ( não assinado )
# saida: server.keystore.jks
#keytool -genkey -keystore /opt/ssl/$HOSTNAME.keystore.jks -alias localhost -validity 365 -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -storetype pkcs12
keytool -genkey -keystore /opt/ssl/$HOSTNAME.keystore.jks -alias $HOSTNAME -validity 365 -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -dname "CN=${HOSTNAME}" -storetype pkcs12 --keyalg RSA



# BROKER SERVER
# Gerar uma requisicao de certificado ( não assinado ) para que o CA possa assinar
# entrada: server.keystore.jks
# saida: cert-file
sleep 2
keytool -keystore /opt/ssl/$HOSTNAME.keystore.jks -alias $HOSTNAME -certreq -file /opt/ssl/cert-file -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -noprompt