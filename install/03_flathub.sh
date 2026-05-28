
if flatpak remote-list | grep flathub
then 
  echo "Flathub is already installed"
else 
  echo "Installing flathub repository"
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi
