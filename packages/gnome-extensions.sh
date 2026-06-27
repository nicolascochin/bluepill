#!/bin/bash

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

install_extension () {
  local uuid="$1"

  print_msg "📦 Installing $uuid"

  # récupérer metadata JSON
  local metadata
  metadata=$(curl -fsSL "${BASE_URL}/extension-info/?uuid=${uuid}")

  local shell_version
  shell_version=$(echo "$metadata" | jq -r '.shell_version_map | keys | sort | last')

  local download_url
  download_url=$(echo "$metadata" | jq -r ".shell_version_map.\"$shell_version\".download_url")

  if [[ "$download_url" == "null" ]]; then
    print_status ko
    echo "No compatible version for GNOME Shell"
    return 1
  fi

  local zip_file="${TMP_DIR}/${uuid}.zip"

  curl -fsSL "${BASE_URL}${download_url}" -o "$zip_file"

  mkdir -p "${INSTALL_DIR}/${uuid}"
  unzip -q "$zip_file" -d "${INSTALL_DIR}/${uuid}"

  print_status ok
}

for ext in "${EXTENSIONS[@]}"; do
  install_extension "$ext" || true
done
