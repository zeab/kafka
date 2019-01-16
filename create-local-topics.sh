#!/bin/bash

#Topics and Retention
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 3 --topic my-topic
kafka-topics.sh --zookeeper localhost:2181 --alter --topic my-topic --config retention.ms=60000
