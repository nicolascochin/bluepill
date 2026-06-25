#!/bin/bash

FONT_DIR=${HOME}/.local/share/fonts

declare -A FONTS=(
  ["FiraCode"]="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
  ["Meslo"]="https://github.com/romkatv/powerlevel10k-media/releases/download/v2.3.3/meslo-lgs-nf.tar.gz"
)

download_and_install_font() {
  local NAME="$1"
  local URL="$2"

  local TMP_ZIP="/tmp/${NAME}.zip"

  print_msg "📥 Installing $NAME"
  if curl -fsSL "$URL" -o "$TMP_ZIP"; then
    unzip -oq "$TMP_ZIP" -d "$FONT_DIR"
    rm -f "$TMP_ZIP"
    print_status ok
  else
    rm -f "$TMP_ZIP"
    print_status ko
    return 1
  fi
}

for FONT_NAME in "${!FONTS[@]}"; do
  download_and_install_font "$FONT_NAME" "${FONTS[$FONT_NAME]}"
done

print_msg "🔄 Refreshing font cache"
fc-cache -fv >/dev/null && print_status ok || print_status ko


curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip
unzip NerdFontsSymbolsOnly.zip -d ~/.local/share/fonts
fc-cache -fv
