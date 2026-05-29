#!/bin/bash

check_flathub() {
  flatpak remotes | grep -q flathub
}

print_msg "Checking if flathub is enabled"
if check_flathub; then
  print_status ok
else
  print_status ko
  print_msg "Enabling flathub"
  flatpak remote-modify --no-filter --enable flathub
  check_flathub && print_status ok || print_status ko
fi
