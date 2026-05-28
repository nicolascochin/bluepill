PACKAGES_TO_INSTALL=(
#  gh                       # Github CLI
  distrobox                # Distrobox
#  libappindicator-gtk3     # Gnome Shell extension for tray icons
  mozilla-https-everywhere # HTTPS enforcement extension for Mozilla Firefox
  podman-compose
  zsh
  fira-code-fonts          # Font
#  solaar                   # Logitech keyboard
#  solaar-udev              # Logitech keyboard
)

is_installed() {
  local cmd="$1"
  command -v "$cmd" &>/dev/null
}

MISSING_PACKAGES=()
for pkg in "${PACKAGES_TO_INSTALL[@]}"; do
  if ! rpm -q "$pkg" &>/dev/null; then
    MISSING_PACKAGES+=("$pkg")
  fi
done

if [ ${#MISSING_PACKAGES[@]} -ne 0 ]; then
  echo "Install packages: ${MISSING_PACKAGES[@]}"
  rpm-ostree install -y "${MISSING_PACKAGES[@]}" >/dev/null 
else
  echo "All packages are already installed."
fi
