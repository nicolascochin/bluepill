needs_conversion() {
    rpm-ostree status --json | jq -e '
        .deployments[0]["requested-local-packages"]
        | map(select(
            startswith("rpmfusion-free-release") or
            startswith("rpmfusion-nonfree-release")
          ))
        | length > 0
    ' >/dev/null
}


if ! needs_conversion; then
  print_msg "📦 RPM Fusion converted"
  print_status ok
else
  run_logged \
    "📦 Converting RPM Fusion LocalPackages into LayeredPackages" \
      sudo rpm-ostree update \
        --uninstall rpmfusion-free-release \
        --uninstall rpmfusion-nonfree-release \
        --install rpmfusion-free-release \
        --install rpmfusion-nonfree-release

  press_enter_to_reboot
fi


