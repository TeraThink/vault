#!/usr/bin/env bash
set -e
PRIVATE_IP=`ip route get 1 | awk '{print $NF;exit}'`
TRUEORFALSE=$2
sudo sed -i "s|@@PRIVATE_IP@@|${PRIVATE_IP}|g" $1
sleep 0.0001
sudo sed -i "s|@@TRUEORFALSE@@|${TRUEORFALSE}|g" $1
