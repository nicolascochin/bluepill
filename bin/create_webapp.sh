#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 3 ]]; then
    echo "Usage: $0 <nom> <url> <icone>"
    echo
    echo "Exemple :"
    echo "  $0 \"ChatGPT\" \"https://chatgpt.com\" chatgpt.png"
    exit 1
fi

APP_NAME="$1"
APP_URL="$2"
ICON_NAME="$3"

APP_ID="$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"

APPLICATIONS_DIR="$HOME/.local/share/applications"
ICONS_DIR="$HOME/.local/share/bluepill/icons"

mkdir -p "$APPLICATIONS_DIR"

ICON_PATH="${ICONS_DIR}/${ICON_NAME}"

if [[ ! -f "$ICON_PATH" ]]; then
    echo "Erreur : l'icône '$ICON_PATH' est introuvable."
    exit 1
fi

cat > "${APPLICATIONS_DIR}/${APP_ID}.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=${APP_NAME}
Exec=xdg-open ${APP_URL}
Icon=${ICON_PATH}
Terminal=false
Categories=Network;
StartupNotify=true
EOF

chmod +x "${APPLICATIONS_DIR}/${APP_ID}.desktop"
