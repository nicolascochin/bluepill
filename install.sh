#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -Eeuo pipefail

BLUEPILL_LOCAL="${BLUEPILL_LOCAL:-${HOME}/.local/share/bluepill}"
INSTALL_DIR=${BLUEPILL_LOCAL}/install
BLUEPILL_LOG="$(mktemp -t bluepill-install-XXXXXX.log)"

# Helpers
for f in ${BLUEPILL_LOCAL}/helpers/*.sh; do
  source "$f"
done
echo "Log file is ${BLUEPILL_LOG}"
echo
run_installers "preflight"
run_installers "packages"
run_installers "config"
echo
echo "Restart the computer"
echo "Check https://github.com/nicolascochin/dotfiles to setup zsh"
