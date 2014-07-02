#!/bin/bash
source "$(dirname $0)/../../lib/shared.sh"

echo "deb http://debian.datastax.com/community stable main" | tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl -L https://debian.datastax.com/debian/repo_key | apt-key add -

apt-get update
apt-get install -y dsc20

# Ensure nothing is installed here!
service cassandra stop
rm -rf /var/lib/cassandra/data/system/*
