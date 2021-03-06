#!/usr/bin/env bash
set -e


# Install packages
sudo yum install -y unzip git


mkdir /var/tmp/consul
cd /var/tmp/consul
# Download Vault into directory
curl -L "${consul_binary_download_url}" > /var/tmp/consul/consul.zip

sudo unzip *.zip -d .

# Setup the configuration
/usr/bin/git init
/usr/bin/git config core.sparsecheckout true
/usr/bin/git remote add -f origin  https://github.com/TeraThink/vault.git
echo "terraform/aws/consul/inputfiles/*" > .git/info/sparse-checkout
echo "terraform/aws/consul/runtimescripts/*" >> .git/info/sparse-checkout
sleep 0.001
/usr/bin/git pull origin master
sleep 0.001


sudo mv consul /usr/local/bin
sudo mkdir -p /etc/consul/config /logs/consul/ /etc/consul/data

sudo cp terraform/aws/consul/inputfiles/demoEnv/consul.json.raw /etc/consul/config/consul.json.raw
sudo cp terraform/aws/consul/inputfiles/demoEnv/consul.service /etc/systemd/system/
sudo chmod 700 terraform/aws/consul/runtimescripts/constructConfig.sh
sleep 1
sudo terraform/aws/consul/runtimescripts/constructConfig.sh /etc/consul/config/consul.json.raw ${server_ui_required} ${cluster_tag_key} ${cluster_tag_value} ${server_or_agent} ${boot_strap_value}

sudo rm -rf /etc/consul/config/consul.json.raw

sleep 0.001
sudo nohup systemctl start consul.service
#1> /logs/vault/vaultstartup.out 2> /logs/vault/vaultstartup.err &
#sudo nohup systemctl start vault.service  > /logs/vault/vaultstartup.log &
sleep 50
sudo systemctl enable consul.service
sleep 10

#systemctl reload-configuration


# ./consul agent -server -data-dir=/var/tmp/consul -client=0.0.0.0 -bind 127.0.0.1 -datacenter=AWS_REGION -bootstrap-expect=3 -ui
