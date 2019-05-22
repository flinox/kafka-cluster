FROM openjdk:8u201-jre-alpine

ARG KFV=2.2.0
ARG SCV=2.12
ARG KFH=/opt/kafka
ARG KFL=/opt/kafka/logs
ARG KFD=/data/kafka
ARG KFC=/config/server.properties

ENV KAFKA_HOME=${KFH} \
    KAFKA_VERSION=${KFV} \
    KAFKA_DATA=${KFD} \
    KAFKA_LOG=${KFL} \
    KAFKA_CONFIG=${KFC} \
    SCALA_VERSION=${SCV} \
    PATH=${PATH}:${KFH}/bin \
    CLASSPATH=${KFH}-${KFV}/lib:${KFH}-${KFV}:/usr/lib/jvm/java-1.8-openjdk/jre \
    USER=kafka \
    UID=1000 \
    GID=1000 

RUN addgroup --gid ${GID} ${USER} \
    && adduser --disabled-password --gecos "" \
        --home ${KAFKA_HOME} \
        --ingroup ${USER} \
        --no-create-home \
        --uid ${UID} ${USER} && \
        echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN apk add --no-cache bash curl jq nano sudo \
    && cd /tmp && wget http://ftp.unicamp.br/pub/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

RUN tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt \
    && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

RUN ln -s kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME} \
    && mkdir ${KAFKA_DATA} -p \
    && mkdir ${KAFKA_LOG}

WORKDIR ${KAFKA_HOME}

# COPY ./conf/* ${KAFKA_HOME}/conf/
COPY start.sh ${KAFKA_HOME}/

RUN chown ${USER}:${GID} ${KAFKA_DATA} \
    && chown ${USER}:${GID} -R ${KAFKA_HOME}_${SCALA_VERSION}-${KAFKA_VERSION} \
    && chown -h ${USER}:${GID} ${KAFKA_HOME} \
    && chown ${USER}:${GID} -R ${KAFKA_LOG}

USER ${USER}

EXPOSE 9092
# EXPOSE 2888-3888

#RUN echo "sed -i 's/zookeeper1/${IP}/g' ${ZOOKEEPER_HOME}/conf/zoo.cfg" >> 

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
#CMD ["start-kafka.sh"]
CMD sh -c "./start.sh"

# ENTRYPOINT sleep infinity
# https://zookeeper.apache.org/doc/r3.1.2/zookeeperAdmin.html#sc_systemReq
# Set the Java heap size. This is very important to avoid swapping, which will seriously degrade ZooKeeper performance. To determine the correct value, use load tests, and make sure you are well below the usage limit that would cause you to swap. Be conservative - use a maximum heap size of 3GB for a 4GB machine.

# Gerar imagem
# docker build -t flinox/kafka_cluster .

# Rodar o container interativo
# export ID=1

# docker run --rm \
# --name kafka${ID} --hostname kafka${ID} \
# --network bridge \
# -u 1000:1000 -e ID=${ID} \
# -v $(pwd)/log/kafka${ID}/:/opt/kafka/log \
# -v $(pwd)/config/kafka${ID}:/opt/kafka/config \
# flinox/kafka_cluster

# Rodar Kafka
# docker run -it --rm \
# --name kafka${ID} --hostname kafka${ID} \
# --network bridge \
# -u 1000:1000 -e ID=${ID} \
# -v $(pwd)/log/kafka${ID}/:/opt/kafka/log \
# -v $(pwd)/config/kafka${ID}:/opt/kafka/config \
# flinox/kafka_cluster sh


# docker run -it --rm \
# --name kafka_client --hostname kafka_client \
# --network kafka_cluster_cluster-net \
# flinox/flinox:v2 /bin/bash


# Após adicionar um novo nó, restartar o zookeeper
# docker exec -it zookeeper1 ./bin/zkServer.sh restart $ZOOCFG


# Rodar o container normal
# docker run --rm --name zookeeper_cluster --hostname zookeeper_cluster -e ID=1 flinox/zookeeper_cluster

