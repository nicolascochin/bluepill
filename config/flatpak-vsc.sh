#!/bin/bash

run_logged "⚙️ Enable podman socket" systemctl --user enable --now podman.socket
run_logged "🛠️ Configure VSC" flatpak override \
  --user com.visualstudio.code \
  --filesystem=/run/user/1000/podman \
  --filesystem=/tmp \
  --env=DOCKER_HOST=unix:///run/user/1000/podman/podman.sock

  run_logged "🔗 Create a symlink docker" sudo ln -sf /run/user/1000/podman/podman.sock /var/run/docker.sock
