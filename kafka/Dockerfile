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

RUN addgroup -S -g ${UID} ${USER} \ 
     && adduser -S -u ${GID} -G ${USER} -s /bin/sh ${USER} -D --gecos "" \
       --home ${ZOOKEEPER_HOME} \
       --ingroup ${USER} \
       --no-create-home \
     && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# RUN addgroup --gid ${GID} ${USER} \
#     && adduser --disabled-password --gecos "" \
#         --home ${KAFKA_HOME} \
#         --ingroup ${USER} \
#         --no-create-home \
#         --uid ${UID} ${USER} && \
#         echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

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

CMD sh -c "./start.sh"

