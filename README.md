
# A kafka use case


## Planejamento

### Stories
- Classifiquei os itens do case como stories, os priorizei de acordo com suas dependências e estimei esforço com planning poker usando fibonacci:

![Stories](/plano/images/2019-05-21-stories.png)

- (*) são stories desejadas/diferenciais.
- O esforço foi estimado apenas para as stories principais do sprint, caso sobre tempo puxarei outras stories (*) para não comprometer a entrega.

### Stories tasks
![Tasks](/plano/images/2019-05-22-stories-tasks.png)


## Acompanhamento

- Capacity: 40 pontos para sprint de 1 semana.
- Burndown planejado:

![Burndown](/plano/images/2019-05-21-burndown.png)


Link para acompanhar em tempo real:

> [Burndown](https://docs.google.com/spreadsheets/d/1on_Sd3mgyJTbZywISEAddIVEQWIgD7vHJqxPstqXXao/edit?usp=sharing)


## Arquitetura proposta

### Diagrama de arquitetura
![Diagrama de Arquitetura](/plano/images/2019-05-21-diagrama-arquitetura.png)

- Cluster com 3 replicas de um container zookeeper;
- Cluster com 3 replicas de um container kafka;
- Armazenamento persistente de dados, configurações e logs fora dos containers de zookeeper e kafka;
- Um container com uma imagem de kafka como client e ferramentas necessárias para desenvolvimento do producer e consumer;
- Um container com prometheus para coletar as métricas e grafana para monitoração;
- Tudo orquestrado por um docker-compose que iniciará os serviços;
- Rodando em notebook pessoal com Linux Mint 64bits.

### Diagrama de implementação
![Diagrama de Implementacao](/plano/images/2019-05-22-diagrama-implementacao.png)

- Itens em azul são containers

## Tecnologias

- Python 3.6.7
- Go 1.12.5
- Docker 18.09.2
- Docker-compose 1.17.1
- Apache Kafka 2.2.0
- Apache Zookeeper 3.5.5
- Prometheus JMX Expoeter Agent 0.11.0
- Prometheus 2.9.2
- Grafana 6.1.6
- Visual Studio Code
- Linux Mint 64bits

## Referências

- https://github.com/flinox/kafka_cluster
- https://www.confluent.io/
- https://kafka.apache.org/
- https://zookeeper.apache.org/
- [Gráfico Burndown e Burnup na nuvem e de graça](https://www.rbco.com.br/graficos-e-indicadores/grafico-burn-down-e-burn-up)
- https://courses.datacumulus.com/kafka-monitoring-b88
- https://github.com/prometheus/jmx_exporter
- https://github.com/prometheus/prometheus
