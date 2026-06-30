#!/bin/bash 

run_logged() {
  local description="$1"
  shift

  print_msg "$description"

  if [[ -n "${BLUEPILL_LOG:-}" ]]; then
    "$@" >>"$BLUEPILL_LOG" 2>&1
  else
    "$@" >/dev/null 2>&1
  fi

  if [[ $? -eq 0 ]]; then
    print_status ok
  else
    print_status ko
    return 1
  fi
}
