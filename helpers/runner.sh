#!/bin/bash 

run_installers() {
  local folder="${1:?Usage: run_installers <folder>}"

  for f in "${BLUEPILL_LOCAL}/${folder}"/*.sh; do
    [[ -f "$f" ]] || continue
    echo -e "\n▶ Running: $f" | tee -a "$BLUEPILL_LOG"
    source "$f"
  done
}

