#!/bin/bash

PACKAGES=(
    distrobox
    podman-compose
    zsh
    alacritty
)

print_msg "📥 Installing silverblue packages"

rpm-ostree install --idempotent --quiet "${PACKAGES[@]}" > /dev/null \
    && print_status ok \
    || print_status ko
