#!/bin/bash

is_firefox_installed() {
  rpm -q firefox >/dev/null 2>&1
}

if ! is_firefox_installed; then
  print_msg "Native Firefox already removed"
  print_status ok
else
  run_logged \
    "🗑️ Removing native Firefox (keeping Flatpak version)" \
    sudo rpm-ostree override remove firefox firefox-langpacks

  press_enter_to_reboot
fi
