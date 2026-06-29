#!/bin/bash

print_msg "⚙️  Setting ZSH shell"
chsh --shell /bin/zsh $(whoami) && print_status ok || print_status ko

print_msg "⚙️  Setting ZSH config"
GIT_EMAIL=github@account.rocks sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply https://github.com/nicolascochin/dotfiles.git \
  && print_status ok \
  || print_status ko
