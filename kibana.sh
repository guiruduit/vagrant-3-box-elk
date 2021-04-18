#!/usr/bin/env bash

sudo apt install gnupg apt-transport-https -y
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update

# install Kibana
sudo apt install kibana -y

# start on boot
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service

# replace config file
sudo mv /tmp/kibana.yml /etc/kibana/

# start
sudo systemctl start kibana.service