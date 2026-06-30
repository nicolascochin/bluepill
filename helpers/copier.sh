#!/bin/bash 

copy_files() {
  local src_folder="${1:?Usage: copy_files <src_folder> <dest_folder>}"
  local dest_folder="${2:?Usage: copy_files <src_folder> <dest_folder>}"

  mkdir -p $dest_folder

  for f in "${BLUEPILL_LOCAL}/${src_folder}"/*; do
    [[ -f "$f" ]] || continue
    run_logged "📋 Copying $f into ${dest_folder}" cp $f ${dest_folder}/ 
  done
}

copy_file() {
  local src="${1:?Usage: copy_file <src> <dest>}"
  local dest="${2:?Usage: copy_file <src> <dest>}"
  local dest_dir

  dest_dir="$(dirname "$dest")"

  if [[ ! -d "$dest_dir" ]]; then
    print_msg "📁 Creating directory $dest_dir"
    run_logged "📁 Creating directory $dest_dir" mkdir -p "$dest_dir"  || return 1
  fi

  print_msg "📋 Copying $src to $dest"
  run_logged "📋 Copying $src to $dest" cp -- "$src" "$dest" || return 1
}
