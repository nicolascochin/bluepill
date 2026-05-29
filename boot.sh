#!/bin/bash

set -euo pipefail

BLUEPILL_REPO="${BLUEPILL_REPO:-nicolascochin/bluepill}"
BLUEPILL_LOCAL="${BLUEPILL_LOCAL:-${HOME}/.local/share/bluepill}"

clear
echo -e "\nCloning Bluepill from: https://github.com/${BLUEPILL_REPO}.git"
rm -rf ${BLUEPILL_LOCAL}/
git clone -q "https://github.com/${BLUEPILL_REPO}.git" ${BLUEPILL_LOCAL}

echo -e "\nInstallation starting..."
source ${BLUEPILL_LOCAL}/install.sh
