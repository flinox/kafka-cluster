#!/bin/sh
cd /opt/ssl
export PASSWORD=verysecret
export VALIDITY=365
# -storetype pkcs12
keytool -keystore kafka.server.keystore.jks -alias $HOSTNAME -validity $VALIDITY -genkey -storepass $PASSWORD -keypass $PASSWORD 
openssl req -new -x509 -keyout ca-key -out ca-cert -days $VALIDITY
keytool -keystore kafka.server.truststore.jks -alias CARoot -import -file ca-cert -storepass $PASSWORD -keypass $PASSWORD -noprompt
keytool -keystore kafka.client.truststore.jks -alias CARoot -import -file ca-cert -storepass $PASSWORD -keypass $PASSWORD -noprompt
keytool -keystore kafka.server.keystore.jks -alias $HOSTNAME -certreq -file cert-file -storepass $PASSWORD -keypass $PASSWORD -noprompt
openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days $VALIDITY -CAcreateserial -passin pass:$PASSWORD
keytool -keystore kafka.server.keystore.jks -alias CARoot -import -file ca-cert -storepass $PASSWORD -keypass $PASSWORD -noprompt
keytool -keystore kafka.server.keystore.jks -alias $HOSTNAME -import -file cert-signed -storepass $PASSWORD -keypass $PASSWORD -noprompt
# -storetype pkcs12
keytool -keystore kafka.client.keystore.jks -alias $HOSTNAME -validity $VALIDITY -genkey -storepass $PASSWORD -keypass $PASSWORD 
keytool -keystore kafka.client.keystore.jks -alias $HOSTNAME -certreq -file cert-file -storepass $PASSWORD -keypass $PASSWORD -noprompt
openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days $VALIDITY -CAcreateserial -passin pass:$PASSWORD
keytool -keystore kafka.client.keystore.jks -alias CARoot -import -file ca-cert -storepass $PASSWORD -keypass $PASSWORD -noprompt
keytool -keystore kafka.client.keystore.jks -alias $HOSTNAME -import -file cert-signed -storepass $PASSWORD -keypass $PASSWORD -noprompt


