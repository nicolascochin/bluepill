#!/bin/bash

run_logged "🛠️ Enable linger" loginctl enable-linger $(whoami) 
run_logged "🛠️ Mkdir tmpfile.d" sudo mkdir -p /etc/tmpfiles.d 
run_logged "🛠️ Create /etc/tmpfiles.d/podman-docker-sock.conf" sudo tee /etc/tmpfiles.d/podman-docker-sock.conf <<'EOF'
L+ /var/run/docker.sock - - - - /run/user/1000/podman/podman.sock
EOF
