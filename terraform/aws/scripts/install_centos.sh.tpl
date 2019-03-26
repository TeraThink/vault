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
git int
git config core.sparsecheckout true
git remote add -f origin  https://github.com/TeraThink/vault.git

echo ${config} > /etc/vault/config.json
sudo cp /tmp/myapp.conf /etc/systemd/system/vault.service



sudo nohup systemctl start vault.service  > /logs/vault/vaultstartup.log &
sleep 0.001
sudo systemctl enable vault.service
sleep 0.001
vault operator init > /etc/vault/init.file
# three times
cat /etc/vault/init.file | grep 'Unseal Key 1:' | cut -d: -f2 | xargs vault operator unseal
cat /etc/vault/init.file | grep 'Unseal Key 2:' | cut -d: -f2 | xargs vault operator unseal
cat /etc/vault/init.file | grep 'Unseal Key 3:' | cut -d: -f2 | xargs vault operator unseal
