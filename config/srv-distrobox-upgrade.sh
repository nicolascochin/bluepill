#!/bin/bash

mkdir -p ${HOME}/.config/systemd/user
copy_file ${BLUEPILL_LOCAL}/files/systemd/user/distrobox-upgrade.service ${HOME}/.config/systemd/user/distrobox-upgrade.service
copy_file ${BLUEPILL_LOCAL}/files/systemd/user/distrobox-upgrade.timer ${HOME}/.config/systemd/user/distrobox-upgrade.timer

run_logged "🔄 Reloading systemd user daemon" systemctl --user daemon-reload 
run_logged "⏰ Enabling Distrobox upgrade timer" systemctl --user enable --now distrobox-upgrade.timer
