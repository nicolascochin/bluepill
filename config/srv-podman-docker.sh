#!/bin/bash

mkdir -p ${HOME}/.config/systemd/user
copy_file ${BLUEPILL_LOCAL}/files/systemd/system/podman-docker-symlink.service /etc/systemd/system/podman-docker-symlink.service

run_logged "🔄 Reloading systemd user daemon" sudo systemctl daemon-reload 
run_logged "📦 Enabling Podman-Docker symlink" sudo systemctl --now podman-docker-symlink.service
