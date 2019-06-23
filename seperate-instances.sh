#####Run Zookeeper
```docker run -d --name=zookeeper --network=host --restart unless-stopped --log-opt max-size=25m -e ZOO_LOG4J_PROP="ERROR"  wurstmeister/zookeeper```
#####Run Kafka
```IP=$(ip route get 8.8.8.8 | head -1 | cut -d' ' -f8) && docker run -d --name=kafka --network=host --restart unless-stopped --log-opt max-size=25m -e LOG4J_LOGGER_KAFKA='ERROR,stdout' -e KAFKA_ADVERTISED_HOST_NAME=$IP -e KAFKA_ZOOKEEPER_CONNECT=localhost:2181 wurstmeister/kafka```
