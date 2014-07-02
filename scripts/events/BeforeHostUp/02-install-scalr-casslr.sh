#!/bin/bash
source "$(dirname $0)/../../lib/shared.sh"

apt-get update
apt-get install -y git python-mysqldb python-setuptools

easy_install pip
pip install  gunicorn
pip install --upgrade casslr
