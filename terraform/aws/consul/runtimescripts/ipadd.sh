#!/usr/bin/env bash
set -e
PRIVATE_IP=`ip route get 1 | awk '{print $NF;exit}'`
EC2_INSTANCE_ID=`ec2metadata | grep instance-id  | cut -d: -f2 | sed 's/^[[:blank:]]*//;s/[[:blank:]]*$//'`
TRUEORFALSE=$2
CLUSTER_TAG_KEY=$3
CLUSTER_TAG_VALUE=$4


sudo cat $1 | sed "s|@@PRIVATE_IP@@|${PRIVATE_IP}|g" | sed "s|@@TRUEORFALSE@@|${TRUEORFALSE}|g" |sed "s|@@EC2_INSTANCE_ID@@|${EC2_INSTANCE_ID}|g" | sed  "s|@@CLUSTER_TAG_KEY@@|${CLUSTER_TAG_KEY}|g" | sed "s|@@CLUSTER_TAG_VALUE@@|${CLUSTER_TAG_VALUE}|g" > /etc/consul/consul.json
