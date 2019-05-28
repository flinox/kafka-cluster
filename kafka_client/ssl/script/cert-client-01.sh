#!/bin/bash

# 01 - CLIENT - gera o request

# CLIENT SERVER
# Gerar um certificado x509 para client ( não assinado )
# saida: client.keystore.jks
keytool -genkey -keystore /opt/ssl/$HOSTNAME.keystore.jks -alias $HOSTNAME -validity 365 -storepass $CLIENTPASSWORD -keypass $CLIENTPASSWORD -dname "CN=${HOSTNAME}" -storetype pkcs12 --keyalg RSA


# CLIENT SERVER
# Gerar uma requisicao de certificado ( não assinado ) para que o CA possa assinar
# entrada: client.keystore.jks
# saida: cert-file
sleep 2
keytool -keystore /opt/ssl/$HOSTNAME.keystore.jks -alias $HOSTNAME -certreq -file /opt/ssl/cert-file -storepass $CLIENTPASSWORD -keypass $CLIENTPASSWORD -noprompt