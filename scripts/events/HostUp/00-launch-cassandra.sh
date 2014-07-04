#!/bin/bash
source "$(dirname $0)/../../lib/shared.sh"

# First, wait for a seed node to be in Running state (indicating Cassandra will
# soon start there)
COUNTER=0
MAX_ATTEMPT=100
WAIT_TIME=10

while [ -z "$(curl --silent --fail --location 127.0.0.1:8020/seeds)" ]; do
  let COUNTER+=1
  [ "${COUNTER}" -gt "${MAX_ATTEMPT}" ] && echo "Too many attempts, exiting" && exit 1
  echo "No seed nodes at $(date)"
  sleep "${WAIT_TIME}"
done

echo "Seed node found!"

CASSANDRA_LOG="/var/log/cassandra/system.log"

service cassandra status && {
  echo "Cassandra is already running"
  exit 1
}

# Truncate the log
echo > "${CASSANDRA_LOG}" || true

service cassandra start

sleep 10

# Escalate the log to Scalr
# We would certainly need something a bit more robust here!
cat "${CASSANDRA_LOG}"

# Run nodetool to output our cluster status
nodetool status || echo "Nodetool returns an error - cluster may not be ready yet"
