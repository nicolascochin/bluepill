#!/bin/bash 

run_installers() {
  local folder="${1:?Usage: run_installers <folder>}"

  for f in "${BLUEPILL_LOCAL}/${folder}"/*.sh; do
    [[ -f "$f" ]] || continue
    echo -e "\nRunning : $f"
    source "$f"
  done
}

