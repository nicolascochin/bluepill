#!/bin/bash

WALLPAPER=stormtrooper_keyboard.jpg
CURRENT_WALLPAPER=${HOME}/Images/current_wallpaper

ln -sf ${BLUEPILL_LOCAL}/files/images/${WALLPAPER} ${HOME}/Images/current_wallpaper

run_logged "🛠️  Setting wallpaper light" gsettings set org.gnome.desktop.background picture-uri "file://$CURRENT_WALLPAPER" 
run_logged "🛠️  Setting wallpaper dark"  gsettings set org.gnome.desktop.background picture-uri-dark "file://$CURRENT_WALLPAPER"
