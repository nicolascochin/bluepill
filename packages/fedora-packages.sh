#!/bin/bash

PACKAGES=(
    distrobox
    podman-compose
    zsh
    chezmoi
)

if has_nvidia_gpu; then
  PACKAGES+=(akmod-nvidia xorg-x11-drv-nvidia-cuda)
fi

run_logged "📥 Installing silverblue packages" rpm-ostree install -y --apply-live --idempotent --quiet "${PACKAGES[@]}" 
