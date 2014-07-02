#!/bin/bash
source "$(dirname $0)/../lib/shared.sh"

EVENT_SCRIPTS_DIR="$(dirname $0)/${SCALR_EVENT_NAME}"

if [ -d "${EVENT_SCRIPTS_DIR}" ]; then
  for executable in "${EVENT_SCRIPTS_DIR}"/*; do
    echo "--- Running Script: ${executable}"
    $executable
  done
else
  echo "--- No handlers registered for ${SCALR_EVENT_NAME}"
fi
