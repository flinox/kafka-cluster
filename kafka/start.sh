#!/bin/sh
#export IP=$(ip route | awk '/link/ { print $7 }')
#export IP_HOST=$(ip route | awk '/default/ { print $3 }')
pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    #kill -SIGTERM "$pid"
    echo ""
    echo ">>> Shutting down kafka $ID ..."
    bin/kafka-server-stop.sh ${KAFKA_CONFIG:1} & 
    wait "$pid"

  fi
  exit 143; # 128 + 15 -- SIGTERM
}

echo ">>> Configurando kafka $ID..."
#sed -i "s/zookeeper$ID/$(ip route | awk '/link/ { print $7 }')/g" $ZOOCFG

qtde_found=$(cat ${KAFKA_CONFIG:1} | grep -c "broker.id=")

if [ $qtde_found -eq 0 ]; then
   #string not contained in file
   echo "broker.id=$ID" >> ${KAFKA_CONFIG:1}
else
   #string is in file at least once
   sed -i -E "s/(broker.id=)[0-9]{1,}/broker.id=$ID/g" ${KAFKA_CONFIG:1}
fi

sleep 2
echo ">>> Starting kafka $ID ..."
bin/kafka-server-start.sh -daemon ${KAFKA_CONFIG:1} & 
pid="$!"

trap 'term_handler' SIGHUP SIGINT SIGTERM

sleep 10
#tail -f /dev/null

#tail -f ${KAFKA_LOG}/server.log & wait
tail -f ${KAFKA_LOG}/kafkaServer.out & wait
