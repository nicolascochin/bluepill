#!/bin/bash

copy_file ${BLUEPILL_LOCAL}/files/systemd/system/podman-docker-symlink.service /etc/systemd/system/podman-docker-symlink.service true

run_logged "🔄 Reloading systemd user daemon" sudo systemctl daemon-reload 
run_logged "📦 Enabling Podman-Docker symlink" sudo systemctl enable --now podman-docker-symlink.service
