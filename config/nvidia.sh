#!/bin/bash

# Nothing to configure without an NVIDIA GPU.
has_nvidia_gpu || return 0

# Disable nouveau from the initramfs and enable the NVIDIA driver's KMS.
# Idempotent:
#   - --append-if-missing: doesn't add a karg that's already present
#   - --unchanged-exit-77: exits 77 without creating a deployment when
#     nothing changes -> so we map 77 to success (like 02_system.sh).
disable_nouveau() {
  local rc=0
  sudo rpm-ostree kargs --unchanged-exit-77 \
    --append-if-missing=rd.driver.blacklist=nouveau \
    --append-if-missing=modprobe.blacklist=nouveau \
    --append-if-missing=nvidia-drm.modeset=1 || rc=$?

  [[ "$rc" -eq 0 || "$rc" -eq 77 ]]
}

run_logged "🛠️  Disabling nouveau at boot" disable_nouveau
