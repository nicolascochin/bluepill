#!/bin/bash 

copy_files() {
  local src_folder="${1:?Usage: copy_files <src_folder> <dest_folder>}"
  local dest_folder="${2:?Usage: copy_files <src_folder> <dest_folder>}"
  local as_root="${3:-false}"
  local sudo_cmd=""

  [[ "$as_root" == "true" ]] && sudo_cmd="sudo"

  $sudo_cmd mkdir -p $dest_folder

  for f in "${BLUEPILL_LOCAL}/${src_folder}"/*; do
    [[ -f "$f" ]] || continue
    run_logged "📋 Copying $f into ${dest_folder}" $sudo_cmd cp $f ${dest_folder}/
  done
}

copy_file() {
  local src="${1:?Usage: copy_file <src> <dest> [as_root]}"
  local dest="${2:?Usage: copy_file <src> <dest> [as_root]}"
  local as_root="${3:-false}"
  local dest_dir
  local sudo_cmd=""

  [[ "$as_root" == "true" ]] && sudo_cmd="sudo"

  dest_dir="$(dirname "$dest")"

  if [[ ! -d "$dest_dir" ]]; then
    run_logged "📁 Creating directory $dest_dir" $sudo_cmd mkdir -p "$dest_dir" || return 1
  fi

  run_logged "📋 Copying $src to $dest" $sudo_cmd cp -- "$src" "$dest" || return 1
}
