#!/bin/bash
print_msg "Checking if a system update is up to date"

if rpm_output=$(rpm-ostree upgrade --check 2>/dev/null); then
    rpm_exit=0
else
    rpm_exit=$?
fi

if [ $rpm_exit -ne 0 ]; then
    print_status ko
    echo "System is currently upgrading. Retry later"
    exit 1
elif echo "$rpm_output" | grep -q "AvailableUpdate"; then
    print_status ko
    echo "Updating the system"
    exit 1
else
    print_status ok
fi
