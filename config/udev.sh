#!/bin/bash

URLS=(
    "https://raw.githubusercontent.com/pwr-Solaar/Solaar/refs/heads/master/rules.d-uinput/42-logitech-unify-permissions.rules"
)

for url in "${URLS[@]}"; do
    dest="/etc/udev/rules.d/$(basename "$url")"

    if [[ -f "$dest" ]]; then
        print_msg "📦  $(basename "$dest") already present"
        print_status ok
    else
        run_logged "📥 Downloading $(basename "$url")" sudo curl -fsSL -o "$dest" "$url"
    fi
done

run_logged "🔄 Reloading udev rules" sudo udevadm control --reload-rules
run_logged "🔄 Triggering udev" sudo udevadm trigger
