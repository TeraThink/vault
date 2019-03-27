#!/usr/bin/env bash
set -e

# Install packages
sudo yum install -y unzip git


mkdir /var/tmp/consul
cd /var/tmp/consul
# Download Vault into directory
curl -L "https://releases.hashicorp.com/consul/1.4.4/consul_1.4.4_linux_amd64.zip" > /var/tmp/consul/consul.zip

sudo unzip *.zip -d .

mv consul /usr/local/bin

cat <<EOF > /etc/systemd/system/consul.conf
description "Consul"

start on filesystem or runlevel [2345]
stop on shutdown

script

    /usr/local/bin/consul agent \
        -client \
        -data-dir=/var/tmp/consul \
        -client=0.0.0.0 \
        -bind 127.0.0.1 \
        -datacenter=AWS_REGION \
        -bootstrap-expect=2 \
        -ui

end script
EOF

#systemctl reload-configuration

sudo nohup systemctl start consul

# ./consul agent -server -data-dir=/var/tmp/consul -client=0.0.0.0 -bind 127.0.0.1 -datacenter=AWS_REGION -bootstrap-expect=3 -ui
