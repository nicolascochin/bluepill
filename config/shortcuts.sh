#!/bin/bash

SCHEMA="org.gnome.settings-daemon.plugins.media-keys"
BASE="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

# id|name|command|binding
SHORTCUTS=(
  "terminal|Terminal|gnome-terminal|<Primary><Alt>t"
  "vscode|VS Code|code|<Primary><Alt>c"
#  "my-script|My Script|/home/$USER/bin/my-script.sh|<Super>F12"
)

# Liste actuelle des raccourcis
current="$(gsettings get "$SCHEMA" custom-keybindings)"

# Extraction des chemins existants
paths=()
while read -r path; do
    [[ -n "$path" ]] && paths+=("$path")
done < <(grep -o "'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/[^']*/'" <<< "$current")

for shortcut in "${SHORTCUTS[@]}"; do
    IFS='|' read -r id name command binding <<< "$shortcut"

    path="$BASE/$id/"
    quoted_path="'$path'"
    schema="$SCHEMA.custom-keybinding:$path"

    # Ajouter le chemin uniquement s'il n'existe pas déjà
    found=false
    for p in "${paths[@]}"; do
        if [[ "$p" == "$quoted_path" ]]; then
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

    gsettings set "$schema" name "$name" \
      && gsettings set "$schema" command "$command" \
      && gsettings set "$schema" binding "$binding" \
      && print_status ok \
      || print_status ko
done

# Mettre à jour la liste des raccourcis
list="[$(IFS=,; echo "${paths[*]}")]"
gsettings set "$SCHEMA" custom-keybindings "$list"
