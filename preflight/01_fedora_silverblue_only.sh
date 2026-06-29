#!/bin/bash

check_silverblue() {
  source /etc/os-release

  if [[ "${ID:-}" != "fedora" || "${VARIANT_ID:-}" != "silverblue" ]]; then
    echo "This script must be run on Fedora Silverblue." >&2
    return 1
  fi
}

run_logged "🔍 Checking system is Fedora Silverblue" check_silverblue || exit 1

