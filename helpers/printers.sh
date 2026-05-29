#!/bin/bash 

print_msg() {
  printf "%s...  " "${1:?Usage: print_msg <message>}"
}

print_status() {
  case "${1:?Usage: print_status <ok|ko>}" in
    ok|OK) printf "[\e[32mOK\e[0m]\n" ;;
    ko|KO) printf "[\e[31mKO\e[0m]\n" ;;
    *)     printf "[??]\n" ;;
  esac
}
