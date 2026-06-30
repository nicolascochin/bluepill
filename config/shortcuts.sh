#!/usr/bin/env bash

SCHEMA="org.gnome.settings-daemon.plugins.media-keys"
BASE="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

SHORTCUTS=(
  "terminal|Terminal|gnome-terminal|<Primary><Alt>t"
  "vscode|VS Code|code|<Primary><Alt>c"
  "distrobox-fedora|Distrobox Fedora|flatpak run org.wezfurlong.wezterm start -- ${HOME}/.local/bin/distroboxctl run --image fedora|<Primary><Shift>F1"
  "distrobox-debian|Distrobox Debian|flatpak run org.wezfurlong.wezterm start -- ${HOME}/.local/bin/distroboxctl run --image debian|<Primary><Shift>F2"
  "distrobox-arch|Distrobox Arch|flatpak run org.wezfurlong.wezterm start -- ${HOME}/.local/bin/distroboxctl run --image archlinux|<Primary><Shift>F3"
  "distrobox-ubuntu|Distrobox Ubuntu|flatpak run org.wezfurlong.wezterm start -- ${HOME}/.local/bin/distroboxctl run --image ubuntu|<Primary><Shift>F4"
)

paths=()

configure_shortcut() {
  local schema="$1"
  local name="$2"
  local command="$3"
  local binding="$4"

  gsettings set "$schema" name "$name" &&
    gsettings set "$schema" command "$command" &&
    gsettings set "$schema" binding "$binding"
}

for shortcut in "${SHORTCUTS[@]}"; do
  IFS='|' read -r id name command binding <<<"$shortcut"

  path="$BASE/$id/"
  schema="$SCHEMA.custom-keybinding:$path"
  quoted_path="'$path'"

  [[ " ${paths[*]} " =~ ${quoted_path} ]] || paths+=("$quoted_path")

  run_logged "🛠️  Configuring shortcut: $name" configure_shortcut "$schema" "$name" "$command" "$binding" 
done

list="[$(IFS=,; echo "${paths[*]}")]"
run_logged "🛠️  Registering custom shortcuts" gsettings set "$SCHEMA" custom-keybindings "$list" 
