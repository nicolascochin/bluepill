#!/bin/bash 

run_logged() {
    local description="$1"
    shift

    print_msg "$description"

    if "$@" >>"$BLUEPILL_LOG" 2>&1; then
        print_status ok
    else
        print_status ko
        return 1
    fi
}
