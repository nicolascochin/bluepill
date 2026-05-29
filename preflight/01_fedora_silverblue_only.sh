#!/bin/bash

source /etc/os-release

if [[ "${ID:-}" != "fedora" || "${VARIANT_ID:-}" != "silverblue" ]]; then
    echo "This script must be run on Fedora Silverblue." >&2
    exit 1
fi

