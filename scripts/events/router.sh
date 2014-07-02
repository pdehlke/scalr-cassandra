#!/bin/bash
source "$(dirname $0)/../lib/shared.sh"

for executable in $(dirname $0)/${SCALR_EVENT_NAME}/*; do
  echo "--- Running Script: ${executable}"
  $executable
done
