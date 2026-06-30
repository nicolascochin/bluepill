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

    flatpak uninstall -y --noninteractive "$app" &&
    flatpak_install "$app"
}

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
    ["org.wezfurlong.wezterm"]="Wezterm"
)

for app in "${!APPS[@]}"; do
    if ! flatpak_installed "$app"; then
        run_logged "📥 Installing ${APPS[$app]}" \
            flatpak_install "$app"
    fi
done

while read -r app; do
    [[ -z "$app" ]] && continue

    run_logged "📥 Re-installing $app from Flathub" \
        reinstall_from_flathub "$app"

done < <(
    flatpak list --app --columns=application,origin |
    awk '$2=="fedora"{print $1}'
)
