#!/bin/bash

set -euo pipefail

EXTENSIONS=(
  "appindicatorsupport@rgcjonas.gmail.com"
  "blur-my-shell@aunetx"
  "clipboard-indicator@tudmotu.com"
  "tilingshell@ferrarodomenico.com"
)

BASE_URL="https://extensions.gnome.org"

INSTALL_DIR="$HOME/.local/share/gnome-shell/extensions"
TMP_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

install_extension () {
  local uuid="$1"

  print_msg "📦 Installing $uuid"

  local metadata
  metadata=$(curl -fsSL "${BASE_URL}/extension-info/?uuid=${uuid}")

  # version GNOME la plus récente disponible
  local shell_version
  shell_version=$(echo "$metadata" | jq -r '.shell_version_map | keys | map(tonumber) | sort | last')

  if [[ -z "$shell_version" || "$shell_version" == "null" ]]; then
    print_status ko
    echo "Could not detect GNOME shell version for $uuid"
    return 1
  fi

  local download_url
  download_url=$(echo "$metadata" | jq -r ".shell_version_map.\"$shell_version\".download_url")

  if [[ -z "$download_url" || "$download_url" == "null" ]]; then
    print_status ko
    echo "No compatible version for GNOME Shell ($shell_version)"
    return 1
  fi

  local zip_file="${TMP_DIR}/${uuid}.zip"

  if ! curl -fsSL "${BASE_URL}${download_url}" -o "$zip_file"; then
    print_status ko
    echo "Download failed for $uuid"
    return 1
  fi

  mkdir -p "${INSTALL_DIR}/${uuid}"
  unzip -q -o "$zip_file" -d "${INSTALL_DIR}/${uuid}"

  print_status ok
}

for ext in "${EXTENSIONS[@]}"; do
  install_extension "$ext" || true
done
