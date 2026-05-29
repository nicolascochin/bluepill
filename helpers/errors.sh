#!/bin/bash 

# Give people a chance to retry running the installation
trap 'echo "BluePill installation failed! You can retry by running: source ${BLUEPILL_LOCAL}/install.sh"' ERR
