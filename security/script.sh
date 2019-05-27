

if [ $# -eq 0 ]
  then
    echo "Informe o nome do broker"
    exit 1
fi

echo 'Preparando arquivos para broker '$1

# CA SERVER
# Criando um CA ( Certificate authority ) privado para assinar os certificados
# saida: ca-cert e ca-key
# openssl req -new -x509 -keyout ca-key -out ca-cert -days 365 

export BROKERNAME=$1
export BROKERPASSWORD=verysecret
export CAPASSWORD=verysecret

## Deletando arquivos antigos
[ ! -e cert-file ] || rm cert-file
[ ! -e cert-signed ] || rm cert-signed
[ ! -e ca-cert.srl ] || rm ca-cert.srl

# BROKER SERVER
# Gerar um certificado x509 para cada kafka broker ( não assinado )
# saida: server.keystore.jks
sleep 3
keytool -keystore $BROKERNAME.keystore.jks -alias $BROKERNAME -validity 365 -genkey -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -ext SAN=DNS:$BROKERNAME -noprompt

# BROKER SERVER
# Gerar uma requisicao de certificado ( não assinado ) para que o CA possa assinar
# entrada: server.keystore.jks
# saida: cert-file
sleep 3
keytool -keystore $BROKERNAME.keystore.jks -alias $BROKERNAME -certreq -file cert-file -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -noprompt

# CA SERVER
# Assinar o certificados do broker
# entrada: cert-file
# saida: cert-signed
sleep 3
openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days 365 -CAcreateserial -passin pass:$CAPASSWORD

# BROKER SERVER
# Importar o certificado assinado e a chave publica do CA que assinou para a keystore
# entrada: ca-cert e cert-signed
# saida: server.keystore.jks updated
sleep 3
keytool -keystore $BROKERNAME.keystore.jks -alias CARoot -import -file ca-cert -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -noprompt
sleep 3
keytool -keystore $BROKERNAME.keystore.jks -alias $BROKERNAME -import -file cert-signed -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -noprompt

# BROKER SERVER
# Importar a chave publica do CA para o truststore
# entrada: ca-cert
# saida: server.truststore.jks 
sleep 3
keytool -keystore $BROKERNAME.truststore.jks -alias CARoot -import -file ca-cert -storepass $BROKERPASSWORD -keypass $BROKERPASSWORD -noprompt

