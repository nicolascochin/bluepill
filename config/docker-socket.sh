#!/bin/bash

TMPFILES_DIR="/etc/tmpfiles.d"
TMPFILES_CONF="${TMPFILES_DIR}/podman-docker-sock.conf"
TMPFILES_LINE="L+ /var/run/docker.sock - - - - /run/user/${UID}/podman/podman.sock"

run_logged "🛠️ Enable linger" loginctl enable-linger $(whoami) 

if [ ! -d "$TMPFILES_DIR" ]; then
  run_logged "🛠️ Mkdir $TMPFILES_DIR" sudo mkdir -p /etc/tmpfiles.d 
else
  print_msg "🛠️  $TMPFILES_DIR exists"
  print_status ok
fi

if [ ! -f "$TMPFILES_CONF" ] || ! grep -qF "$TMPFILES_LINE" "$TMPFILES_CONF" 2>/dev/null; then
  run_logged "📦  Create $TMPFILES_CONF" echo "$TMPFILES_LINE" | sudo tee "$TMPFILES_CONF" > /dev/null
else
  print_msg "🛠️  $TMPFILES_CONF exists"
  print_status ok
fi
