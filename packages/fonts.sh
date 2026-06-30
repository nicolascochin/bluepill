#!/usr/bin/env bash

FONT_DIR="${HOME}/.local/share/fonts"

declare -A FONTS=(
  ["FiraCode"]="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
  ["Meslo"]="https://github.com/romkatv/powerlevel10k-media/releases/download/v2.3.3/meslo-lgs-nf.tar.gz"
)

download_and_install_font() {
  local name="$1"
  local url="$2"
  local tmp_file

  tmp_file="$(mktemp "/tmp/${name}.XXXXXX")"

  if ! curl -fsSL "$url" -o "$tmp_file"; then
    rm -f "$tmp_file"
    return 1
  fi

  case "$url" in
    *.zip)
      unzip -oq "$tmp_file" -d "$FONT_DIR"
      ;;
    *.tar.gz|*.tgz)
      tar -xzf "$tmp_file" -C "$FONT_DIR"
      ;;
    *)
      echo "Unknown archive format: $url" >&2
      rm -f "$tmp_file"
      return 1
      ;;
  esac

  rm -f "$tmp_file"
}

for font in "${!FONTS[@]}"; do
  run_logged "📥 Installing ${font}" download_and_install_font "$font" "${FONTS[$font]}" 
done

run_logged "🔄 Refreshing font cache" \
    fc-cache -fv || exit 1
