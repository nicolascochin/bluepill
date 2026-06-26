#!/bin/bash

DEST_FOLDER=$HOME/.local/bin

print_msg "📥 Copying bin into ${DEST_FOLDER}"
copy_files "bin" $DEST_FOLDER && print_status ok || print_status ko
