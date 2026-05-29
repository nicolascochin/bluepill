#!/bin/bash
print_msg "Checking if a system update is up to date"

if rpm_output=$(rpm-ostree upgrade --check 2>/dev/null); then
    rpm_exit=0
else
    rpm_exit=$?
fi

case $rpm_exit in
  0)
    print_status ko
    echo "An update is available. Please update and retry"
    exit 1
    ;;
  77)
    print_status ok
    ;;
  *)
    print_status ko
    echo "System is busy (e.g. upgrade in progress), retry later"
    ;;
esac
