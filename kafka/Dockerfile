## KAFKA ##

FROM openjdk:13-alpine

ARG KFV=2.7.0
ARG SCV=2.13
ARG PRV=0.14.0
ARG KFH=/opt/kafka
ARG KFL=/opt/kafka/logs
ARG KFD=/data/kafka
ARG KFC=/config/server.properties
ARG PRH=/opt/prometheus

ENV KAFKA_HOME=${KFH} \
    KAFKA_VERSION=${KFV} \
    KAFKA_DATA=${KFD} \
    KAFKA_LOG=${KFL} \
    KAFKA_CONFIG=${KFC} \
    SCALA_VERSION=${SCV} \
    PROMETHEUS_HOME=${PRH} \
    PROMETHEUS_VERSION=${PRV} \     
    PATH=${PATH}:${KFH}/bin \
    CLASSPATH=${KFH}-${KFV}/lib:${KFH}-${KFV}:/opt/openjdk-13/lib \    
    USER=kafka \
    UID=1000 \
    GID=1000

# Create group and user
RUN addgroup -S -g ${UID} ${USER} \ 
     && adduser -S -u ${GID} -G ${USER} -s /bin/sh ${USER} -D --gecos "" \
       --home ${ZOOKEEPER_HOME} \
       --ingroup ${USER} \
       --no-create-home \
     && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install aplications needed
RUN apk add --no-cache bash curl jq nano sudo openssl tzdata ca-certificates iputils openssh 
RUN wget http://ftp.unicamp.br/pub/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -P /tmp

# Adjusting timezone
RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && echo "America/Sao_Paulo" >  /etc/timezone && date

# Extract kafka
RUN tar -xzf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && \
    rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

# Create log e data folder
RUN ln -s kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME} && \
    mkdir -p ${KAFKA_DATA} && mkdir -p ${KAFKA_LOG}

# Download prometheus jmx export agent
RUN mkdir -p ${PROMETHEUS_HOME} && \
    wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${PROMETHEUS_VERSION}/jmx_prometheus_javaagent-${PROMETHEUS_VERSION}.jar -P ${PROMETHEUS_HOME} && \
    wget https://raw.githubusercontent.com/prometheus/jmx_exporter/master/example_configs/kafka-2_0_0.yml -P ${PROMETHEUS_HOME}

WORKDIR ${KAFKA_HOME}

COPY start.sh ${KAFKA_HOME}/

# Setting owners
RUN chown ${USER}:${GID} ${KAFKA_DATA} \
    && chown ${USER}:${GID} -R ${KAFKA_HOME}_${SCALA_VERSION}-${KAFKA_VERSION} \
    && chown -h ${USER}:${GID} ${KAFKA_HOME} \
    && chown ${USER}:${GID} -R ${KAFKA_LOG} \
    && chown ${USER}:${GID} -R ${PROMETHEUS_HOME}

USER ${USER}

EXPOSE 9092
EXPOSE 9093
EXPOSE 8080

CMD sh -c "./start.sh"

