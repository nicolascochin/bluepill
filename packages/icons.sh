#!/bin/bash

FONT_DIR=${HOME}/.local/share/icons
TMP_DIR=$(mktemp -d)
(
  print_msg "📥 Installing papirus icons"
  cd "$TMP_DIR"
  curl -L -o -q papirus.tar.gz https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/archive/refs/heads/master.tar.gz
  tar -xzf papirus.tar.gz
  mkdir -p $FONT_DIR
  cp -r papirus-icon-theme-master/Papirus* $FONT_DIR \
    && print_status ok \
    || print_status ko
)
