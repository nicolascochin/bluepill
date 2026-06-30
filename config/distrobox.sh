#!/bin/bash

DEST_FILE=${HOME}/.config/distrobox/distrobox.conf

mkdir -p $(dirname $DEST_FILE)
copy_file ${BLUEPILL_LOCAL}/files/config/distrobox/distrobox.conf ${DEST_FILE}
