#!/usr/bin/env bash
set -e

echo "Passed Vars 11:: "$cluster_tag_key
echo "Passed Vars 22:: "$cluster_tag_value

# Install packages
sudo yum install -y unzip git


mkdir /var/tmp/consul
cd /var/tmp/consul
# Download Vault into directory
curl -L "https://releases.hashicorp.com/consul/1.4.4/consul_1.4.4_linux_amd64.zip" > /var/tmp/consul/consul.zip

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
sudo mkdir -p /etc/consul/ /logs/consul/

sudo cp terraform/aws/consul/inputfiles/demoEnv/consul.json.raw /etc/consul/consul.json.raw
sudo cp terraform/aws/consul/inputfiles/demoEnv/consul.service /etc/systemd/system/
sudo chmod 700 terraform/aws/consul/runtimescripts/ipadd.sh
sleep 0.001
sudo terraform/aws/consul/runtimescripts/ipadd.sh /etc/consul/consul.json.raw false $cluster_tag_key $cluster_tag_value
sleep 0.001

sudo rm -rf /etc/consul/consul.json.raw

sudo nohup systemctl start consul.service
#1> /logs/vault/vaultstartup.out 2> /logs/vault/vaultstartup.err &
#sudo nohup systemctl start vault.service  > /logs/vault/vaultstartup.log &
sleep 50
sudo systemctl enable consul.service
sleep 10

# ./consul agent -server -data-dir=/var/tmp/consul -client=0.0.0.0 -bind 127.0.0.1 -datacenter=AWS_REGION -bootstrap-expect=3 -ui
