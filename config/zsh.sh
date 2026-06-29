#!/bin/bash

print_msg "⚙️ Setting ZSH shell"
chsh --shell /bin/zsh $(whoami) && print_status ok || print_status ko
