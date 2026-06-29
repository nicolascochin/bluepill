#!/bin/bash

AUTORUN_DIR="${HOME}/.config/autostart"
FLATPAK_DIR="/var/lib/flatpak/app"
AUTO_APPS=(
  "${FLATPAK_DIR}/com.protonvpn.www.desktop"
)

mkdir -p "$AUTORUN_DIR"

for src in "${AUTO_APPS[@]}"; do
  target="$(basename "$src")"
  link="${AUTORUN_DIR}/${target}"

  if [[ ! -e "$link" ]]; then
    print_msg "🚀 Autostart $target" \
      && ln -s "$src" "$link" \
      && print_status ok \
      || print_status ko
  fi
done
