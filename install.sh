#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -Eeuo pipefail

BLUEPILL_LOCAL="${BLUEPILL_LOCAL:-${HOME}/.local/share/bluepill}"
INSTALL_DIR=${BLUEPILL_LOCAL}/install

# Helpers
for f in ${BLUEPILL_LOCAL}/helpers/*.sh; do
  source "$f"
done

run_installers "preflight"
run_installers "packages"
