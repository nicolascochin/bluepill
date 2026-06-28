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

    print_msg "📦 Installing ${uuid}"

    local json
    if ! json=$(curl -fsSL \
        "${BASE_URL}/extension-info/?uuid=${uuid}&shell_version=${GNOME_VERSION}"); then
        print_status ko
        return 1
    fi

    local download_url
    download_url="$(jq -r '.download_url // empty' <<<"$json")"

    if [[ -z "$download_url" ]]; then
        print_status ko
        echo "No compatible version found for GNOME ${GNOME_VERSION}"
        return 1
    fi

    local zip_file="${TMP_DIR}/${uuid}.zip"

    if ! curl -fsSL "${BASE_URL}${download_url}" -o "$zip_file"; then
    echo "coucou"
        print_status ko
        return 1
    fi

    if ! gnome-extensions install --force "$zip_file" &>/dev/null; then
        print_status ko
        return 1
    fi

    print_status ok

    print_msg "🔌 Enabling ${uuid}"

    gnome-extensions enable "$uuid" \
        && print_status ok \
        || print_status ko
}

for ext in "${EXTENSIONS[@]}"; do
    install_extension "$ext" || true
done
