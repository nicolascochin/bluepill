#!/usr/bin/env bash

flatpak_install() {
  local app="$1"

  flatpak install flathub \
    -y \
    --noninteractive \
    "$app"
}

flatpak_installed() {
  local app="$1"

  flatpak info "$app" >/dev/null 2>&1
}

reinstall_from_flathub() {
  local app="$1"

  flatpak uninstall -y --noninteractive "$app" \
    && flatpak_install "$app"
}

FFMPEG_BRANCH="$(
  flatpak list --runtime --columns=application,branch \
    | awk '$1=="org.freedesktop.Platform"{print $2; exit}'
)"

declare -A APPS=(
  ["com.protonvpn.www"]="Proton VPN"
  ["me.proton.Pass"]="Proton Pass"
  ["com.spotify.Client"]="Spotify"
  ["org.videolan.VLC"]="VLC"
  ["com.brave.Browser"]="Brave Browser"
  ["org.mozilla.firefox"]="Firefox Browser"
  ["io.podman_desktop.PodmanDesktop"]="Podman Desktop"
  ["rest.insomnia.Insomnia"]="Insomnia"
  ["com.slack.Slack"]="Slack"
  ["com.discordapp.Discord"]="Discord"
  ["io.github.CyberTimon.RapidRAW"]="Rapid RAW"
  ["com.visualstudio.code"]="Visual Studio Code"
  ["org.wezfurlong.wezterm"]="Wezterm"
  ["com.valvesoftware.Steam"]="Steam"
  ["io.github.pwr_solaar.solaar"]="Solaar"
  ["io.github.dvlv.boxbuddyrs"]="Box Buddy"
  ["io.github.gutopardini.wayshot"]="Wayshot"
)

declare -A APPS_INTERACTIVE=(
  ["org.freedesktop.Platform.ffmpeg-full"]="Codecs ffmpeg"
)

for app in "${!APPS[@]}"; do
  if ! flatpak_installed "$app"; then
    run_logged "📥 Installing ${APPS[$app]}" flatpak_install "$app" || true
  fi
done

for app in "${!APPS_INTERACTIVE[@]}"; do
  if ! flatpak_installed "$app"; then
    run_logged "📥 Installing ${APPS_INTERACTIVE[$app]}" flatpak install flathub -y "$app" || true
  fi
done

while read -r app; do
  [[ -z "$app" ]] && continue

  run_logged "📥 Re-installing $app from Flathub" reinstall_from_flathub "$app"
done < <(
  flatpak list --app --columns=application,origin | awk '$2=="fedora"{print $1}'
)
