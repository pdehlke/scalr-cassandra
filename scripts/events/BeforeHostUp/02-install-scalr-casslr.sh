#!/bin/bash
source "$(dirname $0)/../../lib/shared.sh"

# Dependencies
apt-get update
apt-get install -y python-setuptools

# Casslr itself
easy_install pip
pip install  gunicorn
pip install --upgrade casslr

# Add the launch script
CASSLR_INSTALL_DIR="/usr/local/bin"
mkdir -p "${CASSLR_INSTALL_DIR}"

LAUNCH_CASSLR="${CASSLR_INSTALL_DIR}/launch-casslr"
cp "$(dirname $0)/../../files/launch-casslr" "${LAUNCH_CASSLR}"
chmod 755 "${LAUNCH_CASSLR}"
