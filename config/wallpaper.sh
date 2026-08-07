#!/bin/bash

run_logged "🔗  Link wallpapers" ln -fs ~/.local/share/bluepill/files/wallpapers/ ~/Images/Wallpapers
run_logged "🛠️  Setting wallpaper" ${BLUEPILL_LOCAL}/files/bin/change_wallpaper
