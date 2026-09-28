#!/bin/bash

# Encryption key of the Proton Pass CLI session when no keyring is available, e.g. in the
# Allot devcontainer (PROTON_PASS_KEY_PROVIDER=env). Generated once on this machine and never
# committed. environment.d exports it to the whole graphical session, so VS Code sees it
# (${localEnv:PROTON_PASS_ENCRYPTION_KEY}) after the next login.
# An existing file is never overwritten: a new key makes the kept sessions unreadable.

PROTON_PASS_ENV_FILE="${HOME}/.config/environment.d/proton-pass.conf"

create_proton_pass_env_file() {
  mkdir -p "$(dirname "$PROTON_PASS_ENV_FILE")"
  (
    umask 077
    printf 'PROTON_PASS_ENCRYPTION_KEY=%s\n' "$(od -An -N32 -tx1 /dev/urandom | tr -d ' \n')" > "$PROTON_PASS_ENV_FILE"
  )
}

if [[ -f "$PROTON_PASS_ENV_FILE" ]]; then
  print_msg "🔑 Proton Pass encryption key"
  print_status "ok"
else
  run_logged "🔑 Generating Proton Pass encryption key" create_proton_pass_env_file
fi
