# Consumers

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `consumers` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:consumers, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/consumers>.

```
===> Compiling /vagrant/processing_attrs_changes/deps/crc32cer/c_src/crc32c.c
===> sh: 1: exec: cc: not found

==> consumers

** (Mix) Could not compile dependency :crc32cer, "/home/vagrant/.mix/elixir/1-15/rebar3 bare compile --paths /vagrant/processing_attrs_changes/_build/dev/lib/*/ebin" command failed. Errors may have been logged above. You can recompile this dependency with "mix deps.compile crc32cer --force", update it with "mix deps.update crc32cer" or clean it with "mix deps.clean crc32cer"

```

To resolve the issue
```
sudo apt install build-essential
```


## Connecting application to kafka

Look at [contact_analytics_umbrella](https://github.com/AlexeyAlexey/contact_analytics_umbrella/tree/feture/custom-attrs-mongodb)

[MongoDB Kafka Connector](https://www.mongodb.com/docs/kafka-connector/current/quick-start/#std-label-kafka-quick-start) is used


There is a good topic [Kafka Listeners – Explained](https://www.confluent.io/blog/kafka-listeners-explained/)


```
docker-compose -p mongo-kafka down
```

/home/office/Documents/elixir/dockers/kafka-edu/docs-examples/mongodb-kafka-base/docker-compose.yml


```
  broker:
    image: confluentinc/cp-kafka:7.2.2
    hostname: broker
    container_name: broker
    ports:
      - "9092:9092" <--------------
    depends_on:
      - zookeeper
    networks:
      - localnet
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: "zookeeper:2181"
      KAFKA_LISTENERS: LISTENER_1://broker:29092,LISTENER_2://broker:9092
      KAFKA_ADVERTISED_LISTENERS: LISTENER_1://broker:29092,LISTENER_2://10.0.2.2:9092  <---------------
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: LISTENER_1:PLAINTEXT,LISTENER_2:PLAINTEXT
      KAFKA_INTER_BROKER_LISTENER_NAME: LISTENER_1
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
      KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS: 0
      CONFLUENT_SUPPORT_CUSTOMER_ID: "anonymous"
      KAFKA_DELETE_TOPIC_ENABLE: "true"
```

```
docker-compose -p mongo-kafka up -d --force-recreate
```

LISTENER_2://localhost:9092 --> LISTENER_2://10.0.2.2:9092

I use Vagrant to develop. An apllication (client) that is run in vagrant is external to Docker and external to the host machine wants to connect

Unless specified otherwise in Vagrantfile, the IP address of the host (the computer running Vagrant) from the perspective of the guest (the VM being run by Vagrant) is: 10.0.2.2 (https://gist.github.com/lsloan/6f4307a2cab2aaa16feb323adf8d7959)


[KafkaEx.ConsumerGroup](https://hexdocs.pm/kafka_ex/KafkaEx.ConsumerGroup.html)

[KafkaEx.GenConsumer](https://hexdocs.pm/kafka_ex/KafkaEx.GenConsumer.html)


```shell
iex -S mix
```


```elixir
KafkaEx.GenConsumer.start_link(Consumers.AttrsChanges.Inserts, "attrs_changes_insets_group", "contact_analytics.contacts", 0,
                               commit_interval: 5000,
                               commit_threshold: 100)
```