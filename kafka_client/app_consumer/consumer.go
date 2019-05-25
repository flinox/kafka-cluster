package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"strings"
	"time"

	"github.com/Shopify/sarama"
	"github.com/wvanbergen/kafka/consumergroup"
)

var (
	consumer_group = os.Getenv("CONSUMER_GROUP")
	kafka_topic    = os.Getenv("KAFKA_TOPIC")
	zookeeper_host = os.Getenv("ZOOKEEPER_HOST")
	latest_offset  = sarama.OffsetNewest
	latest_check   = true
	verbose        = false
	p              = fmt.Println
)

func init() {
	flag.StringVar(&kafka_topic, "topic", kafka_topic, "Tópico que deseja consumir as mensagens")
	flag.StringVar(&consumer_group, "consumer", consumer_group, "Consumer group das mensagens")
	flag.StringVar(&zookeeper_host, "zookeeper", zookeeper_host, "Lista dos zookeepers")
	flag.BoolVar(&latest_check, "latest", latest_check, "Informe false para buscar as mensagens mais antigas")
	flag.BoolVar(&verbose, "verbose", verbose, "Informe se quer log mais verboso")
}

func main() {

	flag.Parse()

	if !latest_check {
		latest_offset = sarama.OffsetOldest
	}

	// setup sarama log to stdout
	//sarama.Logger = log.New(os.Stdout, "", log.Ltime)
	if verbose {
		sarama.Logger = log.New(os.Stderr, "", log.LstdFlags)
	}

	// init consumer
	cg, err := initConsumer()
	if err != nil {
		p("Error consumer goup: ", err.Error())
		os.Exit(1)
	}
	defer cg.Close()

	// run consumer
	consume(cg)
}

func initConsumer() (*consumergroup.ConsumerGroup, error) {

	// consumer config
	config := consumergroup.NewConfig()
	config.Offsets.Initial = latest_offset
	config.Offsets.ProcessingTimeout = 10 * time.Second

	// join to consumer group
	cg, err := consumergroup.JoinConsumerGroup(consumer_group, strings.Split(kafka_topic, ","), strings.Split(zookeeper_host, ","), config)
	if err != nil {
		return nil, err
	}

	return cg, err
}

func consume(cg *consumergroup.ConsumerGroup) {
	for {
		select {
		case msg := <-cg.Messages():
			// messages coming through chanel
			// only take messages from subscribed topic
			if msg.Topic != kafka_topic {
				continue
			}

			p(">>> Partition:", msg.Partition, " Offset:", msg.Offset, " Topico:", msg.Topic, " Mensagem:", string(msg.Value))

			// commit to zookeeper that message is read
			// this prevent read message multiple times after restart
			err := cg.CommitUpto(msg)
			if err != nil {
				p("Error commit zookeeper: ", err.Error())
				os.Exit(1)
			}
		}
	}
}
