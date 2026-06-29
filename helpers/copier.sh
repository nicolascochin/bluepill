#!/bin/bash 

copy_files() {
  local src_folder="${1:?Usage: copy_files <src_folder> <dest_folder>}"
  local dest_folder="${2:?Usage: copy_files <src_folder> <dest_folder>}"

  mkdir -p $dest_folder

  for f in "${BLUEPILL_LOCAL}/${src_folder}"/*; do
    [[ -f "$f" ]] || continue
    print_msg "📋 Copying $f into ${dest_folder}"
    cp $f ${dest_folder}/ && print_status ok || print_status ko
  done
}

copy_file() {
  local src="${1:?Usage: copy_file <src> <dest>}"
  local dest="${2:?Usage: copy_file <src> <dest>}"
  local dest_dir

  dest_dir="$(dirname "$dest")"

  if [[ ! -d "$dest_dir" ]]; then
    print_msg "📁 Creating directory $dest_dir"
    mkdir -p "$dest_dir" && print_status ok || {
      print_status ko
      return 1
    }
  fi

  print_msg "📋 Copying $src to $dest"
  if cp -- "$src" "$dest"; then
    print_status ok
  else
    print_status ko
    return 1
  fi
}
