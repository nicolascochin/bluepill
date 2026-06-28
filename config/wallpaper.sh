#!/bin/bash

URL="https://unsplash.com/fr/photos/jouets-de-moto-blancs-et-bleus--kakq3VMtqU"
DIR="$HOME/images"
FILE="$DIR/wallpaper.jpg"

mkdir -p "$DIR"

print_msg "⬇️ Downloading wallpaper"

IMG_URL=$(curl -s "$URL" \
  | grep -oP '(?<=property="og:image" content=")[^"]+' \
  | head -n 1)

curl -L "$IMG_URL" -o "$FILE" && print_status ok || print_status ko

print_msg "🛠️ Setting wallpaper light" && gsettings set org.gnome.desktop.background picture-uri "file://$FILE" && print_status ok || print_status ko
print_msg "🛠️ Setting wallpaper dark"  && gsettings set org.gnome.desktop.background picture-uri-dark "file://$FILE" && print_status ok || print_status ko
