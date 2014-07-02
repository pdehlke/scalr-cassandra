#!/bin/bash
source "$(dirname $0)/../../lib/shared.sh"

CASSANDRA_LOG="/var/log/cassandra/system.log"

service cassandra status && {
  echo "Cassandra is already running"
  exit 1
}

# Truncat the log
echo > "${CASSANDRA_LOG}"

service cassandra start

sleep 10

# Escalate the log to Scalr
# We would certainly need something a bit more robust here!
cat "${CASSANDRA_LOG}"
