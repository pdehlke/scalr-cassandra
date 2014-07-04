#!/bin/bash
source "$(dirname $0)/../../lib/shared.sh"

CASSANDRA_CNF_DIR="/etc/cassandra"
CASSANDRA_YAML="${CASSANDRA_CNF_DIR}/cassandra.yaml"
CASSANDRA_DC="${CASSANDRA_CNF_DIR}/cassandra-rackdc.properties"

# Backup files
cp "${CASSANDRA_YAML}" "${CASSANDRA_YAML}-$(date +%s).bak"
cp "${CASSANDRA_DC}" "${CASSANDRA_DC}-$(date +%s).bak"

# Configuration files
cat << EOF > "${CASSANDRA_YAML}"
cluster_name: '${SCALR_FARM_ROLE_ALIAS}'
num_tokens: 256
seed_provider:
  - class_name: com.scalr.cassandra.ScalrSeedProvider
    parameters:
      - cassandra_needs_a_dummy_param: '1'
listen_address: ${SCALR_INTERNAL_IP}
endpoint_snitch: GossipingPropertyFileSnitch
EOF

cat "$(dirname $0)/../../files/cassandra.yaml.base" >> "${CASSANDRA_YAML}"

# This could largely be improved by using more precis information.
# This is simply a sample, however
cat << EOF > "${CASSANDRA_DC}"
dc=${SCALR_CLOUD_LOCATION}
rack=${SCALR_CLOUD_LOCATION_ZONE}
EOF

# Library to use casslr in Cassandra as a seed_provider in Cassandra
JAR_SRC=https://s3.amazonaws.com/com.scalr-training.cassandra/scalr-cassandra-0.2.jar
JAR_DEST=/usr/share/cassandra/lib/scalr-cassandra.jar

curl --fail --location --silent --output "${JAR_DEST}" "${JAR_SRC}"
chmod 644 "${JAR_DEST}"
