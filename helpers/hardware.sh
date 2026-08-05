#!/bin/bash

# Vrai si un GPU NVIDIA est présent sur le bus PCI.
# Détection via sysfs (aucune dépendance) : vendor 0x10de + classe
# "Display controller" (0x03xxxx), ce qui exclut le contrôleur audio HDMI.
has_nvidia_gpu() {
  local dev vendor class
  for dev in /sys/bus/pci/devices/*; do
    [[ -r "$dev/vendor" && -r "$dev/class" ]] || continue
    read -r vendor < "$dev/vendor"
    read -r class  < "$dev/class"
    [[ "$vendor" == "0x10de" && "$class" == 0x03* ]] && return 0
  done
  return 1
}
