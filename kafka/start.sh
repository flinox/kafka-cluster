#!/bin/sh
pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
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

sleep 5
echo ">>> Starting kafka $ID ..."
bin/kafka-server-start.sh ${KAFKA_CONFIG:1} & 
pid="$!"

trap 'term_handler' SIGHUP SIGINT SIGTERM

sleep 5

#tail -f ${KAFKA_LOG}/server.log & 
wait
