#!/bin/bash

_pds_conf="/etc/tmpfiles.d/podman-docker.conf"
_pds_sock="/run/user/${UID}/podman/podman.sock"

run_logged "⚙️ Enable podman socket" systemctl --user enable --now podman.socket
run_logged "🛠️ Configure VSC" flatpak override \
  --user com.visualstudio.code \
  --filesystem=/run/user/1000/podman \
  --filesystem=/tmp \
  --env=DOCKER_HOST=unix:///run/user/1000/podman/podman.sock

  # run_logged "🔗 Create a symlink docker" sudo ln -sf /run/user/1000/podman/podman.sock /var/run/docker.sock

print_msg "🔗 Create file ${_pds_conf}"
if printf 'L+ /run/docker.sock - - - - %s\n' "${_pds_sock}" | sudo tee "${_pds_conf}" >/dev/null; then
 print_status ok
else
  print_status ko 
fi 


run_logged "🔗 Apply config file" sudo systemd-tmpfiles --create "${_pds_conf}"
