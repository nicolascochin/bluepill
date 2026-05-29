#!/bin/bash

print_msg "Checking if a system update is up to date"

if rpm-ostree upgrade --check 2> /dev/null | grep -q "AvailableUpdate"
then     
  print_status ko
  echo "Updating the system"
  exit 1
else     
  print_status ok
fi
