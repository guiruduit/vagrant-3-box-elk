Vagrant.configure("2") do |config|

  config.ssh.forward_agent = true

  config.vm.define "elasticsearch" do |el|
    el.vm.box_check_update = false
    el.vm.box = "debian/buster64"
    el.vm.hostname = "elasticsearch"
    el.vm.network "private_network", ip: "172.27.11.50"

    el.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
    end

    el.vm.network :forwarded_port, guest: 9200, host: 9200
    el.vm.network :forwarded_port, guest: 9300, host: 9300

    el.vm.provision :file,
      source: "./config/elasticsearch.yml",
      destination: "/tmp/elasticsearch.yml"

    el.vm.provision :shell, :path => "elasticsearch.sh"
  end

  config.vm.define "kibana" do |ki|
    ki.vm.box_check_update = false
    ki.vm.box = "debian/buster64"
    ki.vm.hostname = "kibana"
    ki.vm.network "private_network", ip: "172.27.11.55"

    ki.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 2
    end

    ki.vm.network :forwarded_port, guest: 5601, host: 5601

    ki.vm.provision :file,
      source: "./config/kibana.yml",
      destination: "/tmp/kibana.yml"

    ki.vm.provision :shell, :path => "kibana.sh"
  end

  config.vm.define "logstash" do |lg|
    lg.vm.box_check_update = false
    lg.vm.box = "debian/buster64"
    lg.vm.hostname = "logstash"
    lg.vm.network "private_network", ip: "172.27.11.60"

    lg.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
    end

    lg.vm.network :forwarded_port, guest: 5044, host: 5044
    lg.vm.network :forwarded_port, guest: 5000, host: 5000 # TCP / UDP
    lg.vm.network :forwarded_port, guest: 9600, host: 9600

    lg.vm.provision :file,
      source: "./pipeline/logstash.conf",
      destination: "/tmp/logstash.conf"

    lg.vm.provision :file,
      source: "./pipeline/apache.conf",
      destination: "/tmp/apache.conf"

    lg.vm.provision :shell, :path => "logstash.sh"
  end

  config.vm.define "host1" do |h1|
    h1.vm.box_check_update = false
    h1.vm.box = "debian/buster64"
    h1.vm.hostname = "host1"
    h1.vm.network "private_network", ip: "172.27.11.101"

    h1.vm.provision :file, 
      source: "./config/filebeat.yml",
      destination: "/tmp/filebeat.yml"

    h1.vm.provision :shell, :path => "filebeat.sh"
  end
end