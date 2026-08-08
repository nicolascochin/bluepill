#!/usr/bin/env bash

EXTENSIONS=(
  "appindicatorsupport@rgcjonas.gmail.com"
  "azwallpaper@azwallpaper.gitlab.com"
  "blur-my-shell@aunetx"
  "clipboard-indicator@tudmotu.com"
  "tilingshell@ferrarodomenico.com"
  "status-area-horizontal-spacing@mathematical.coffee.gmail.com"
)

EXTENSIONS_DIR="${HOME}/.local/share/gnome-shell/extensions"

# S'assure que les extensions utilisateur sont autorisées
gsettings set org.gnome.shell disable-user-extensions false

install_extension() {
  local uuid="$1"

  if [[ -d "${EXTENSIONS_DIR}/${uuid}" ]]; then
    return 0
  fi

  gdbus call --session \
    --dest org.gnome.Shell.Extensions \
    --object-path /org/gnome/Shell/Extensions \
    --method org.gnome.Shell.Extensions.InstallRemoteExtension "${uuid}" || true
}

for ext in "${EXTENSIONS[@]}"; do
  run_logged "📦 Installing ${ext}" install_extension "$ext"
done
