#!/bin/bash

SETTINGS_FILE="${HOME}/.var/app/com.visualstudio.code/config/Code/User/settings.json"

init_vscode_settings() {
  mkdir -p "$(dirname "$SETTINGS_FILE")"

  cat > "$SETTINGS_FILE" <<EOF
{
    "dev.containers.dockerPath": "${HOME}/.local/bin/podman",
    "dev.containers.dockerComposePath": "${HOME}/.local/bin/podman-compose"
}
EOF
}

if [[ -f "$SETTINGS_FILE" ]]; then
  print_status "ok" "settings.json déjà initialisé"
else
  run_logged "🛠️  Initializing VS Code settings.json" init_vscode_settings
fi
