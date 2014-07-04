#!/bin/bash
# This script is in charge of inspecting the event that is being processed
# and executing the appropriate scripts.
# This script should be used as an Orchestration Target for All Events.
source "$(dirname $0)/../lib/shared.sh"

# Identify the directory where the Scripts corresponding to the Event
# being processed are located.
EVENT_SCRIPTS_DIR="$(dirname $0)/${SCALR_EVENT_NAME}"

# If any scripts are available, run them all.
if [ -d "${EVENT_SCRIPTS_DIR}" ]; then
  for executable in "${EVENT_SCRIPTS_DIR}"/*; do
    echo "--- Running Script: ${executable}"
    $executable
  done
else
  echo "--- No handlers registered for ${SCALR_EVENT_NAME}"
fi
