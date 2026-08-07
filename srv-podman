#!/bin/bash

mkdir -p ${HOME}/.config/systemd/user
copy_file ${BLUEPILL_LOCAL}/files/systemd/user/podman-docker-symlink.service ${HOME}/.config/systemd/user/podman-docker-symlink.service

run_logged "🔄 Reloading systemd user daemon" systemctl --user daemon-reload 
run_logged "📦 Enabling Podman-Docker symlink" systemctl --user enable --now podman-docker-symlink.service
