press_enter_to_reboot() {
    if [[ ! -t 0 ]]; then
        echo "Reboot required. Please reboot manually."
        return 0
    fi

    echo
    read -rp "Press ENTER to reboot..." _
    sudo systemctl reboot
}
