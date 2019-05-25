package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"os"
	"os/signal"
	"strings"
	"syscall"
	"time"

	"github.com/Shopify/sarama"
)

var (
	kafka_host  = os.Getenv("KAFKA_HOST")
	kafka_topic = os.Getenv("KAFKA_TOPIC")
	p           = fmt.Println
	loop        = flag.Bool("loop", false, "Produzir mensagens de teste infinitamente")
	verbose     = false
)

func init() {
	flag.StringVar(&kafka_topic, "topic", kafka_topic, "Tópico que deseja produzir as mensagens")
	flag.StringVar(&kafka_host, "kafka", kafka_host, "Lista de kafka brokers")
	flag.BoolVar(&verbose, "verbose", verbose, "Informe se quer log mais verboso")
}

func main() {

	flag.Parse()

	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	go func() {
		<-c
		p("\nShutting down the program...")
		// clean
		os.Exit(0)
	}()

	// create producer
	producer, err := initProducer()
	if err != nil {
		p("Error producer: ", err.Error())
		os.Exit(1)
	}

	if *loop {

		for {
			msg := string(time.Now().Format("02/01/2006 15:04:05-0700") + " Nova mensagem !")
			time.Sleep(3 * time.Second)
			publish(msg, producer)
		}

	} else {

		scanner := bufio.NewScanner(os.Stdin)
		for {
			fmt.Print("Enter msg: ")
			scanner.Scan()
			msg := scanner.Text()
			publish(msg, producer)
		}

	}

}

func initProducer() (sarama.SyncProducer, error) {

	// setup sarama log to stdout
	//sarama.Logger = log.New(os.Stdout, "", log.Ltime)
	if verbose {
		sarama.Logger = log.New(os.Stderr, "", log.LstdFlags)
	}

	// producer config
	config := sarama.NewConfig()
	config.Producer.Retry.Max = 5
	config.Producer.RequiredAcks = sarama.WaitForAll
	config.Producer.Return.Successes = true

	// sync producer
	prd, err := sarama.NewSyncProducer(strings.Split(kafka_host, ","), config)

	return prd, err
}

func publish(message string, producer sarama.SyncProducer) {

	// publish sync
	msg := &sarama.ProducerMessage{
		Topic: kafka_topic,
		Value: sarama.StringEncoder(message),
	}
	partition, offset, err := producer.SendMessage(msg)
	if err != nil {
		p(">>> Error publish: ", err.Error())
		os.Exit(1)
	}

	p(">>> Partition:", partition, " Offset:", offset, " Topico:", kafka_topic, " Mensagem:", message)

}
