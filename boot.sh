#!/bin/bash

set -euo pipefail

source /etc/os-release

if [[ "${ID:-}" != "fedora" || "${VARIANT_ID:-}" != "silverblue" ]]; then
    echo "This script must be run on Fedora Silverblue." >&2
    exit 1
fi

clear
BLUEPILL_REPO="${BLUEPILL_REPO:-nicolascochin/bluepill}"

echo -e "\nCloning Bluepill from: https://github.com/${BLUEPILL_REPO}.git"
rm -rf ${HOME}/.local/share/bluepill}/
git clone -q "https://github.com/${BLUEPILL_REPO}.git" ${HOME}/.local/share/bluepill}

echo -e "\nInstallation starting..."
source ${HOME}/.local/share/bluepill}/install.sh
