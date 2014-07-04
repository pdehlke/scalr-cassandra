#!/bin/bash
source "$(dirname $0)/../../lib/shared.sh"

# Constants
PPA_BASE_URL="http://ppa.launchpad.net/webupd8team/java/ubuntu"
PPA_KEY_ID="EEA14886"

# Accept agreement before installing
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# Figure out codename
CODENAME=$(lsb_release -sc)

curl --silent --head --fail "${PPA_BASE_URL}/dists/${CODENAME}" >/dev/null || {
  # If not using an Ubuntu dist, default to precise (that's the best we can do!)
  CODENAME="precise"
}

# Add the PPA
WEBUPD8_PPA_FILE=/etc/apt/sources.list.d/webupd8team.sources.list

echo "deb ${PPA_BASE_URL} ${CODENAME} main" | tee "${WEBUPD8_PPA_FILE}"
echo "deb-src ${PPA_BASE_URL} ${CODENAME} main" | tee "${WEBUPD8_PPA_FILE}"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "${PPA_KEY_ID}"

# Install Java
apt-get update
apt-get install -y oracle-java7-installer
