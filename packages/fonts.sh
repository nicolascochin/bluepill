#!/bin/bash

declare -A FONTS=(
  ["MesloLGS NF Regular.ttf"]="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
  ["MesloLGS NF Bold.ttf"]="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
  ["MesloLGS NF Italic.ttf"]="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
  ["MesloLGS NF Bold Italic.ttf"]="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
)
FONT_DIR=${HOME}/.local/share/fonts

for FONT_NAME in "${!FONTS[@]}"; do 
  FONT_URL="${FONTS[$FONT_NAME]}"
  print_msg "Installing font $FONT_NAME"
  curl -fsSL "$FONT_URL" -o "${FONT_DIR}/${FONT_NAME}" \
    && print_status ok \
    || print_status ko
done
