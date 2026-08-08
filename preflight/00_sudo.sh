#!/usr/bin/env bash

if [ "$(id -u)" -eq 0 ]; then
    return 
else
    sudo -v
fi
