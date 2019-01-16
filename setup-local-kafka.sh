#!/bin/sh

#Set Env Vars
#########
OS_USERNAME=${OS_USERNAME:-$USER}
KAFKA_VERSION=${KAFKA_VERSION:-0.11.0.3}
KAFKA_SCALA_VERSION=${KAFKA_SCALA_VERSION:-2.12}
#########

if [[ ! "$INSTALL_KAFKA_NATIVE" =~ ^(true|yes|on|1|TRUE|YES|ON])$ ]]; then
  #Install Kafka: Native
  #########
  echo "**********Install Kafka: Native**********"
  #download kafka
  wget -O /tmp/kafka.tar.gz http://www-us.apache.org/dist/kafka/${KAFKA_VERSION}/${KAFKA_SCALA_VERSION}-${KAFKA_VERSION}.tgz
  #unzip from tmp to usr/share
  sudo tar xfz /tmp/kafka.tar.gz -C /usr/share/
  #make new kafka dir
  sudo mkdir /usr/share/kafka/
  #move the interior unziped folder to new versionless kafka
  sudo mv /usr/share/kafka*/* /usr/share/kafka
  #remove the old folder
  sudo rm -r /usr/share/kafka_2.12-0.11.0.3
  #give that folder excution rights
  sudo chmod -R +x /usr/share/kafka/bin
  #add the kafka commands to the path for everyone
  sudo sed -i 's,PATH=\",PATH=\"/usr/share/kafka/bin:,g' /etc/environment
  #########    
  exit
fi

#Start Kafka: Docker
#########
docker run -d --name=kafka --restart unless-stopped --log-opt max-size=25m -p 2181:2181 -p 9092:9092 --env ADVERTISED_HOST=localhost --env ADVERTISED_PORT=9092 spotify/kafka
#########