#!/bin/bash

source /etc/os-release
print_msg "🔍 Checking system is a silverblue"

if [[ "${ID:-}" != "fedora" || "${VARIANT_ID:-}" != "silverblue" ]]; then
  print_status ko
  echo "This script must be run on Fedora Silverblue." >&2
  exit 1
else 
  print_status ok
fi

