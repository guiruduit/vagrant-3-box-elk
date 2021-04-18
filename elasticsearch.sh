#!/usr/bin/env bash

sudo apt install gnupg apt-transport-https openjdk-11-jre-headless -y
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update

# install
sudo apt install elasticsearch -y

# start on boot
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service

# replace config file
sudo mv /tmp/elasticsearch.yml /etc/elasticsearch/

# cria arquivo que limita o uso de memória RAM pelo Elasticsearch para 256 Mb
sudo touch ES_JAVA_OPTS
sudo echo "-Xmx256m -Xms256m" >> ES_JAVA_OPTS
sudo mv ES_JAVA_OPTS /etc/elasticsearch/jvm.options.d/

# start
sudo systemctl start elasticsearch.service
