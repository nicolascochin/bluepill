FREE="rpmfusion-free-release"
NONFREE="rpmfusion-nonfree-release"

is_installed() {
    rpm-ostree status --json | jq -e --arg pkg "$1" '
        .deployments[0]
        | (
            (.packages // [])
            + (."requested-packages" // [])
            + (."requested-local-packages" // [])
          )
        | any((. == $pkg) or startswith($pkg + "-"))
    ' >/dev/null
}

if is_installed "$FREE" && is_installed "$NONFREE"; then
    print_msg "RPM Fusion installed"
    print_status ok
else
  run_logged \
    "Installing RPM Fusion repositories" \
    sudo rpm-ostree install \
      "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
      "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

  press_enter_to_reboot
fi


