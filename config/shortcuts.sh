#!/bin/bash

SCHEMA="org.gnome.settings-daemon.plugins.media-keys"
BASE="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

# id|name|command|binding
SHORTCUTS=(
  "terminal|Terminal|gnome-terminal|<Primary><Alt>t"
  "vscode|VS Code|code|<Primary><Alt>c"
  "distrobox-fedora|Distrobox Fedora|flatpak run org.wezfurlong.wezterm start -- ${HOME}/.local/bin/distroboxctl run --image fedora|<Primary><Shift>F1"
  "distrobox-debian|Distrobox Debian|flatpak run org.wezfurlong.wezterm start -- ${HOME}/.local/bin/distroboxctl run --image debian|<Primary><Shift>F2"
  "distrobox-arch|Distrobox Arch|flatpak run org.wezfurlong.wezterm start -- ${HOME}/.local/bin/distroboxctl run --image archlinux|<Primary><Shift>F3"
  "distrobox-ubuntu|Distrobox Ubuntu|flatpak run org.wezfurlong.wezterm start -- ${HOME}/.local/bin/distroboxctl run --image ubuntu|<Primary><Shift>F4"
#  "my-script|My Script|/home/$USER/bin/my-script.sh|<Super>F12"
)
paths=()

for shortcut in "${SHORTCUTS[@]}"; do
    IFS='|' read -r id name command binding <<< "$shortcut"

    path="$BASE/$id/"
    quoted_path="'$path'"
    schema="$SCHEMA.custom-keybinding:$path"

    # Ajouter le chemin uniquement s'il n'existe pas déjà
    found=false

    for p in "${paths[@]}"; do
        if [[ "$p" == "'$path'" ]]; then
            found=true
            break
        fi
    done

    if ! $found; then
        paths+=("$quoted_path")
        print_msg "🛠️ Adding shortcut: $name"
    else
        print_msg "🛠️ Updating shortcut: $name"
    fi

    command gsettings set "$schema" name "$name" \
      && command gsettings set "$schema" command "$command" \
      && command gsettings set "$schema" binding "$binding" \
      && print_status ok \
      || print_status ko
done

list="[$(IFS=,; echo "${paths[*]}")]"
command gsettings set "$SCHEMA" custom-keybindings "$list"
