#!/bin/bash

FONT_DIR=${HOME}/.local/share/icons

print_msg "📥 Copying icons into ${FONT_DIR}"
copy_files "icons" $FONT_DIR && print_status ok || print_status ko

