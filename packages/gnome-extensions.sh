#!/usr/bin/env bash

EXTENSIONS=(
    "appindicatorsupport@rgcjonas.gmail.com"
    "blur-my-shell@aunetx"
    "clipboard-indicator@tudmotu.com"
    "tilingshell@ferrarodomenico.com"
    "status-area-horizontal-spacing@mathematical.coffee.gmail.com"
)

BASE_URL="https://extensions.gnome.org"
GNOME_VERSION="$(gnome-shell --version | awk '{print $3}')"

TMP_DIR="$(mktemp -d)"

# S'assure que les extensions utilisateur sont autorisées
gsettings set org.gnome.shell disable-user-extensions false

install_extension() {
    local uuid="$1"

    print_msg "📦 Installing ${ext}"
    (gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "${ext}" > /dev/null 2>&1 || true) && print_status ok
}



for ext in "${EXTENSIONS[@]}"; do
  install_extension "$ext" || true
done
