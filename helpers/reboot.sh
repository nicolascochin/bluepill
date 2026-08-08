press_enter_to_reboot() {
  if [[ ! -t 0 ]]; then
    echo "Reboot required. Please reboot manually."
    return 0
  fi

  local key
  while true; do
    echo
    read -rsn1 -p "Press ENTER to reboot..." key
    [[ -z "$key" ]] && break
  done

  echo
  sudo systemctl reboot
  exit 0
}
