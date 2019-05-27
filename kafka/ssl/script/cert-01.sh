#!/bin/sh

export BROKERNAME=$HOSTNAME
export BROKERPASSWORD=verysecret
export CAPASSWORD=verysecret

# 01 - BROKER

# BROKER SERVER
# Gerar um certificado x509 para cada kafka broker ( não assinado )
# saida: server.keystore.jks
#keytool -genkey -keystore /opt/ssl/$BROKERNAME.keystore.jks -alias localhost -validity 365 -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -storetype pkcs12
keytool -genkey -keystore /opt/ssl/$BROKERNAME.keystore.jks -alias $BROKERNAME -validity 365 -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -dname "CN=${BROKERNAME}" -storetype pkcs12



# BROKER SERVER
# Gerar uma requisicao de certificado ( não assinado ) para que o CA possa assinar
# entrada: server.keystore.jks
# saida: cert-file
sleep 2
keytool -keystore /opt/ssl/$BROKERNAME.keystore.jks -alias $BROKERNAME -certreq -file /opt/ssl/cert-file -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -noprompt