#!/usr/bin/env bash

# baixa e instala o filebeat
sudo curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.12.0-amd64.deb
sudo dpkg -i filebeat-7.12.0-amd64.deb

# altera as permissões do arquivo config e copia para o diretório correto
sudo chown root:root /tmp/filebeat.yml
sudo mv /tmp/filebeat.yml /etc/filebeat/filebeat.yml

# habilita module system e configura o filebeat
sudo filebeat modules enable system
sudo filebeat setup -e

# start filebeat service 
sudo systemctl enable filebeat
sudo systemctl start filebeat
