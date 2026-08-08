#!/bin/bash

TARGET_SHELL="/bin/zsh"
CURRENT_SHELL="$(getent passwd "$(whoami)" | cut -d: -f7)"

if [[ "$CURRENT_SHELL" == "$TARGET_SHELL" ]]; then
  print_status "ok" "ZSH déjà configuré comme shell par défaut"
else
  run_logged "⚙️  Setting ZSH shell" pkexec chsh --shell "$TARGET_SHELL" "$(whoami)"
fi

#print_msg "⚙️  Setting ZSH config"
#sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply https://github.com/nicolascochin/dotfiles.git \
#  && print_status ok \
#  || print_status ko
