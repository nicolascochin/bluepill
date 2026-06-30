#!/bin/bash

PACKAGES=(
    distrobox
    podman-compose
    zsh
    chezmoi
)

run_logged "📥 Installing silverblue packages" rpm-ostree install -y --apply-live --idempotent --quiet "${PACKAGES[@]}" 
