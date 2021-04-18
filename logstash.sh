#!/usr/bin/env bash

sudo apt install gnupg apt-transport-https openjdk-11-jre-headless -y
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update

# install stack
sudo apt install logstash -y

# atualiza permissão dos diretórios do logstash
sudo chown -R logstash.logstash /usr/share/logstash
sudo chmod 777 /usr/share/logstash/data

# cria os pipelines do logstash
cd /tmp
chown root:root apache.conf logstash.conf
sudo mv apache.conf logstash.conf /etc/logstash/conf.d/

# limita o uso de memória RAM pelo Logstash para 256 Mb
sudo sed -i -e 's/Xms1g/Xms256m/' /etc/logstash/jvm.options
sudo sed -i -e 's/Xmx1g/Xmx256m/' /etc/logstash/jvm.options
