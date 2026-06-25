#!/bin/bash 

copy_files() {
  local src_folder="${1:?Usage: copy_files <src_folder> <dest_folder>}"
  local dest_folder="${2:?Usage: copy_files <src_folder> <dest_folder>}"

  mkdir -p $dest_folder

  for f in "${BLUEPILL_LOCAL}/${src_folder}"/*; do
    [[ -f "$f" ]] || continue
    print_msg "📥 Copying $f into ${dest_folder}"
    cp $f ${dest_folder}/ && print_status ok || print_status ko
  done
}
