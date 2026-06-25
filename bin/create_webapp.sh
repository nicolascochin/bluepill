#!/usr/bin/env bash

set -euo pipefail

APP_NAME="$1"
APP_URL="$2"
#APP_ICON="$3"

APP_DIR=${HOME}/.local/share/applications
DESKTOP_ID="$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"

mkdir -p $APP_DIR

cat > ${APP_DIR}/${DESKTOP_ID}.desktop <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=${APP_NAME}
Exec=xdg-open ${APP_URL}
Icon=web-browser
Terminal=false
Categories=Network;
EOF

chmod +x ~/.local/share/applications/${DESKTOP_ID}.desktop

