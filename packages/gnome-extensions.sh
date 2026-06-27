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

install_extension () {
  local uuid="$1"

  print_msg "📦 Installing $uuid"

  local zip_file="${TMP_DIR}/${uuid}.zip"
  local url="${BASE_URL}/extension-data/${uuid}.shell-extension.zip"

  if ! curl -fsSL "$url" -o "$zip_file"; then
    print_status ko
    echo "Download failed: $uuid"
    return 1
  fi

  mkdir -p "${INSTALL_DIR}/${uuid}"
  unzip -q -o "$zip_file" -d "${INSTALL_DIR}/${uuid}"

  print_status ok
}

for ext in "${EXTENSIONS[@]}"; do
  install_extension "$ext" || true
done
