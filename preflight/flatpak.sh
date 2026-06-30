#!/bin/bash

check_flathub() {
    flatpak remotes | grep -q '^flathub$'
}

enable_flathub() {
    flatpak remote-modify --no-filter --enable flathub
}


flatpak remote-add --if-not-exists \
    flathub \
    https://dl.flathub.org/repo/flathub.flatpakrepo >/dev/null

run_logged "🔍 Checking if Flathub is enabled" \
    check_flathub || {

    run_logged "🔧 Enabling Flathub" \
        enable_flathub || exit 1

    run_logged "🔍 Verifying Flathub is enabled" \
        check_flathub || exit 1
}
