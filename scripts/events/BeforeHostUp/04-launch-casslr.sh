#!/bin/bash
source "$(dirname $0)/../../lib/shared.sh"

CASSLR_PIDFILE="/var/run/casslr"
CASSLR_HOST="127.0.0.1"
CASSLR_PORT=8020

# Try and restart gunicorn.
# If doesn't restart, we need to launch it.

kill -HUP `cat "${CASSLR_PIDFILE}"` || {
  gunicorn --daemon --pid /var/run/casslr --bind "${CASSLR_HOST}:${CASSLR_PORT}" \
  --access-logfile /var/log/casslr.access.log --error-logfile /var/log/casslr.error.log \
  casslr.app:app
}

echo "Started"

# Here again we need something more robust

sleep 10

tail -n 50 /var/log/casslr.error.log

exit 0
