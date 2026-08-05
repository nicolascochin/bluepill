#!/usr/bin/env bash

print_msg "Authentification sudo"

if [ "$(id -u)" -eq 0 ]; then
    print_status ok
elif sudo -v; then
    print_status ok
else
    print_status ko
fi
