#!/bin/bash

declare -A APPS=(
  ["com.protonvpn.www"]="Proton VPN"
  ["me.proton.Pass"]="Proton Pass"
  ["me.proton.Mail"]="Proton Mail"
  ["com.spotify.Client"]="Spotify"
  ["org.videolan.VLC"]="VLC"
  ["com.brave.Browser"]="Brave Browser"
  ["io.podman_desktop.PodmanDesktop"]="Podman Desktop"
  ["rest.insomnia.Insomnia"]="Insomnia"
  ["com.slack.Slack"]="Slack"
  ["com.discordapp.Discord"]="Discord"
  ["io.github.CyberTimon.RapidRAW"]="Rapid RAW"
  ["com.visualstudio.code"]="Visual Studio Code"
)
for KEY in "${!APPS[@]}"; do 
  NAME="${APPS[$KEY]}"
  print_msg "Installing ${NAME}"
  if flatpak info ${KEY} > /dev/null 2&>1 
  then 
    print_status ok
  else 
    flatpak install -y --noninteractive $KEY >/dev/null \
      && print_status ok \
      || print_status ko
  fi
done

for KEY in flatpak list --app --columns=application,origin | awk '$2=="fedora"{print $1}'
do
  print_msg "Re-installing $KEY from flathub"
  print_status ok
done

