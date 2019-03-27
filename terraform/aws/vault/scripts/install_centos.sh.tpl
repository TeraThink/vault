#!/usr/bin/env bash
set -e

# Install packages
sudo yum install -y unzip git


mkdir /var/tmp/vault
cd /var/tmp/vault
# Download Vault into some temporary directory
sudo wget "${download_url}/${vaultversion}/${vaultzipfile}"

# Unzip it
sudo unzip *.zip -d .
sudo cp vault /usr/bin/
sudo chmod 0755 /usr/bin/vault
sudo chown root:root /usr/bin/vault

sudo mkdir /etc/vault
sudo mkdir /vault-data
sudo mkdir -p /logs/vault/

# Setup the configuration
/usr/bin/git init
/usr/bin/git config core.sparsecheckout true
/usr/bin/git remote add -f origin  https://github.com/TeraThink/vault.git
echo "terraform/aws/inputfiles/*" > .git/info/sparse-checkout
echo "terraform/aws/runtimescripts/*" >> .git/info/sparse-checkout
sleep 0.001
/usr/bin/git pull origin master
sleep 0.001


sudo cp terraform/aws/inputfiles/demoEnv/config.json /etc/vault/config.json
sudo cp terraform/aws/inputfiles/demoEnv/vault.service /etc/systemd/system/
sudo chmod 700 terraform/aws/runtimescripts/ipadd.sh
sleep 1
sudo terraform/aws/runtimescripts/ipadd.sh
sleep 1

sleep 0.001
sudo nohup systemctl start vault.service
#1> /logs/vault/vaultstartup.out 2> /logs/vault/vaultstartup.err &
#sudo nohup systemctl start vault.service  > /logs/vault/vaultstartup.log &
sleep 100
sudo systemctl enable vault.service
sleep 10
export VAULT_ADDR=http://127.0.0.1:8200
sleep 10
/usr/bin/vault operator init > /etc/vault/init.file
# three times
sleep 10

cat /etc/vault/init.file | grep 'Unseal Key 1:' | cut -d: -f2 | xargs /usr/bin/vault operator unseal
cat /etc/vault/init.file | grep 'Unseal Key 2:' | cut -d: -f2 | xargs /usr/bin/vault operator unseal
cat /etc/vault/init.file | grep 'Unseal Key 3:' | cut -d: -f2 | xargs /usr/bin/vault operator unseal
