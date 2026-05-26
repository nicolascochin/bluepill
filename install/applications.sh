declare -A APPS=(
  ["com.protonvpn.www"]="Proton VPN"
  ["com.spotify.Client"]="Spotify"
  ["org.videolan.VLC"]="VLC"
  ["com.brave.Browser"]="Brave Browser"
  ["io.podman_desktop.PodmanDesktop"]="Podman Desktop"
  ["rest.insomnia.Insomnia"]="Insomnia"
  ["com.slack.Slack"]="Slack"
  ["com.discordapp.Discord"]="Discord"
)
for KEY in "${!APPS[@]}"; do 
  NAME="${APPS[$KEY]}"
  ! flatpak list | grep -q $KEY && (echo "Install $NAME" && flatpak install -y $KEY) || echo "$NAME already installed"
done
