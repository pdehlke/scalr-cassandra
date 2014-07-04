#!/bin/bash
source "$(dirname $0)/../../lib/shared.sh"

kill -HUP `cat "${CASSLR_PIDFILE}"` || /usr/local/bin/launch-casslr
