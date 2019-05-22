FROM openjdk:8u201-jre-alpine

ARG ZKV=3.4.14
ARG ZKH=/opt/zookeeper
ARG ZKL=/opt/zookeeper/log
ARG ZKD=/data/zookeeper
ARG ZKC=/conf/zoo.cfg

ENV ZOOKEEPER_HOME=${ZKH} \
    ZOOKEEPER_DATA=${ZKD} \
    ZOOKEEPER_VERSION=${ZKV} \
    ZOO_LOG_DIR=${ZKL} \
    ZOOCFG=${ZKH}${ZKC} \
    PATH=${PATH}:${ZKH}/bin \
    CLASSPATH=${ZKH}-${ZKV}/lib:${ZKH}-${ZKV}:/usr/lib/jvm/java-1.8-openjdk/jre \
    USER=zookeeper \
    UID=1000 \
    GID=1000 

RUN addgroup --gid ${GID} ${USER} \
    && adduser --disabled-password --gecos "" \
       --home ${ZOOKEEPER_HOME} \
       --ingroup ${USER} \
       --no-create-home \
       --uid ${UID} ${USER} && \
       echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN apk add --no-cache bash curl jq nano sudo openrc \
    && cd /tmp && wget http://ftp.unicamp.br/pub/apache/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz

RUN tar xfz /tmp/zookeeper-${ZOOKEEPER_VERSION}.tar.gz -C /opt \
    && rm /tmp/zookeeper-${ZOOKEEPER_VERSION}.tar.gz

RUN ln -s ${ZOOKEEPER_HOME}-${ZOOKEEPER_VERSION} ${ZOOKEEPER_HOME} \
    && mkdir ${ZOOKEEPER_DATA} -p \
    && mkdir ${ZOO_LOG_DIR}

WORKDIR ${ZOOKEEPER_HOME}

COPY ./conf/* ${ZOOKEEPER_HOME}/conf/
COPY start.sh ${ZOOKEEPER_HOME}/

RUN chown ${USER}:${GID} ${ZOOKEEPER_DATA} \
    && chown ${USER}:${GID} -R ${ZOOKEEPER_HOME}-${ZOOKEEPER_VERSION} \
    && chown -h ${USER}:${GID} ${ZOOKEEPER_HOME} \
    && chown ${USER}:${GID} -R ${ZOO_LOG_DIR} 

USER ${USER}

EXPOSE 2181
EXPOSE 2888-3888

CMD sh -c "./start.sh"

# Gerar imagem
#############################################################
# docker build -t flinox/zookeeper .

# Rodar o container interativo
#############################################################
# export ID=1
# docker run --rm \
# --name zookeeper${ID} --hostname zookeeper${ID} \
# --network bridge \
# -u 1000:1000 -e ID=${ID} \
# -v $(pwd)/zookeeper/data/zookeeper${ID}/:/data/zookeeper \
# -v $(pwd)/zookeeper/log/zookeeper${ID}/:/opt/zookeeper/log \
# -v $(pwd)/zookeeper/conf/:/opt/zookeeper/conf \
# flinox/zookeeper

