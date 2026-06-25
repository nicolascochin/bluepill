#!/bin/bash

declare -A APPS=(
  ["com.protonvpn.www"]="Proton VPN"
  ["com.spotify.Client"]="Spotify"
  ["org.videolan.VLC"]="VLC"
  ["com.brave.Browser"]="Brave Browser"
  ["io.podman_desktop.PodmanDesktop"]="Podman Desktop"
  ["rest.insomnia.Insomnia"]="Insomnia"
  ["com.slack.Slack"]="Slack"
)
for KEY in "${!APPS[@]}"; do 
  NAME="${APPS[$KEY]}"
  print_msg "Installing ${NAME}"
  if flatpak info ${KEY} > /dev/null 2&>1 
  then 
    print_status ok
  else 
    flatpak install -y $KEY) \
      && print_status ok \
      || print_status ko
  fi
done

