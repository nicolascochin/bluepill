#!/bin/bash

run_logged "⚙️  Setting ZSH shell" chsh --shell /bin/zsh $(whoami) 

#print_msg "⚙️  Setting ZSH config"
#sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply https://github.com/nicolascochin/dotfiles.git \
#  && print_status ok \
#  || print_status ko
