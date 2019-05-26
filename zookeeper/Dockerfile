## ZOOKEEPER ##

FROM openjdk:8u201-jre-alpine

ARG ZKV=3.4.14
ARG PRV=0.11.0
ARG ZKH=/opt/zookeeper
ARG ZKL=/opt/zookeeper/log
ARG ZKD=/data/zookeeper
ARG ZKC=/conf/zoo.cfg
ARG PRH=/opt/prometheus

ENV ZOOKEEPER_HOME=${ZKH} \
    ZOOKEEPER_DATA=${ZKD} \
    ZOOKEEPER_VERSION=${ZKV} \
    ZOO_LOG_DIR=${ZKL} \
    ZOOCFG=${ZKH}${ZKC} \
    PROMETHEUS_HOME=${PRH} \  
    PROMETHEUS_VERSION=${PRV} \  
    PATH=${PATH}:${ZKH}/bin \
    CLASSPATH=${ZKH}-${ZKV}/lib:${ZKH}-${ZKV}:/usr/lib/jvm/java-1.8-openjdk/jre \
    USER=zookeeper \
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
RUN apk add --no-cache bash curl jq nano sudo openrc acl openssl tzdata \
    && cd /tmp && wget http://ftp.unicamp.br/pub/apache/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz

# Adjusting timezone
RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && echo "America/Sao_Paulo" >  /etc/timezone && date

# Extract zookeeper 
RUN tar xfz /tmp/zookeeper-${ZOOKEEPER_VERSION}.tar.gz -C /opt \
    && rm /tmp/zookeeper-${ZOOKEEPER_VERSION}.tar.gz

# Create log e data folder
RUN ln -s ${ZOOKEEPER_HOME}-${ZOOKEEPER_VERSION} ${ZOOKEEPER_HOME} \
    && mkdir -p ${ZOOKEEPER_DATA} \
    && mkdir -p ${ZOO_LOG_DIR}

# Download prometheus jmx export agent
RUN mkdir -p ${PROMETHEUS_HOME} \
    && wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${PROMETHEUS_VERSION}/jmx_prometheus_javaagent-${PROMETHEUS_VERSION}.jar -P ${PROMETHEUS_HOME} \
    && wget https://github.com/prometheus/jmx_exporter/blob/master/example_configs/zookeeper.yaml -P ${PROMETHEUS_HOME}

WORKDIR ${ZOOKEEPER_HOME}

# Copying files
COPY start.sh ${ZOOKEEPER_HOME}/

# Setting owners
RUN chown ${UID}:${GID} ${ZOOKEEPER_DATA} \
    && chown ${UID}:${GID} -R ${ZOOKEEPER_HOME}-${ZOOKEEPER_VERSION} \
    && chown -h ${UID}:${GID} ${ZOOKEEPER_HOME} \
    && chown ${UID}:${GID} -R ${ZOO_LOG_DIR} \
    && chown ${UID}:${GID} -R ${PROMETHEUS_HOME}    

USER ${UID}

EXPOSE 2181
EXPOSE 2888-3888
EXPOSE 8080

CMD sh -c "./start.sh"
