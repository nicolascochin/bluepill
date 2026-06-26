#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <nom> <url>"
    exit 1
fi

APP_NAME="$1"
APP_URL="$2"

DESKTOP_ID="$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"

ICON_DIR="$HOME/.local/share/icons/webapps"
APP_DIR="$HOME/.local/share/applications"

mkdir -p "$ICON_DIR" "$APP_DIR"

ICON_PATH="${ICON_DIR}/${DESKTOP_ID}.png"

# Télécharge le favicon s'il n'existe pas déjà
if [[ ! -f "$ICON_PATH" ]]; then
    DOMAIN=$(echo "$APP_URL" | sed -E 's#https?://([^/]+)/?.*#\1#')

    echo "Téléchargement de l'icône pour ${DOMAIN}..."

    curl -fsSL \
        "https://www.google.com/s2/favicons?domain=${DOMAIN}&sz=256" \
        -o "$ICON_PATH"
fi

cat > "${APP_DIR}/${DESKTOP_ID}.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=${APP_NAME}
Exec=chromium --app=${APP_URL}
Icon=${ICON_PATH}
Terminal=false
Categories=Network;
StartupNotify=true
EOF

chmod +x "${APP_DIR}/${DESKTOP_ID}.desktop"

