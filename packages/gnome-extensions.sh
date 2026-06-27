#!/usr/bin/env bash

set -euo pipefail

EXTENSIONS=(
  "appindicatorsupport@rgcjonas.gmail.com"
  "blur-my-shell@aunetx"
  "clipboard-indicator@tudmotu.com"
  "tilingshell@ferrarodomenico.com"
)

INSTALL_DIR="$HOME/.local/share/gnome-shell/extensions"
TMP_DIR="$(mktemp -d)"

install_extension () {
  local uuid="$1"

  print_msg "📦 Installing $uuid"

  local zip_file="${TMP_DIR}/${uuid}.zip"

  # ⭐ LE BON ENDPOINT (le seul fiable)
  local url="https://extensions.gnome.org/download-extension/${uuid}.shell-extension.zip?shell_version=99"

  if ! curl -fsSL "$url" -o "$zip_file"; then
    print_status ko
    return 1
  fi

  mkdir -p "${INSTALL_DIR}/${uuid}"
  unzip -q -o "$zip_file" -d "${INSTALL_DIR}/${uuid}"

  print_status ok
}


enable_extension () {
  local uuid="$1"

  if gnome-extensions list | grep -q "$uuid"; then
    print_msg "📦 Enabling $uuid"
    gnome-extensions enable "$uuid" && print_status ok || print_status ko
  fi
}

for ext in "${EXTENSIONS[@]}"; do
  install_extension "$ext" || true
  enable_extension "$ext" || true
done
