#!/usr/bin/env bash
set -e
PRIVATE_IP=`ip route get 1 | awk '{print $NF;exit}'`
sudo sed -i "s|@@PRIVATE_IP@@|${PRIVATE_IP}|g" /etc/vault/config.json
