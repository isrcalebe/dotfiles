#!/bin/bash

if [ ! -f /etc/os-release ]; then
  ohai_err "$(tput setaf 1)Error: Unable to determine OS. /etc/os-release file not found."
  ohai_err "Installation stopped."
  exit 1
fi

. /etc/os-release

# Check if running on Arch Linux
if [ "$ID" != "manjaro" ] && [ "$ID" != "arch" ]; then
  ohai_err "$(tput setaf 1)Error: OS requirement not met"
  ohai_err "You are currently running: $ID"
  ohai_err "OS required: Manjaro GNOME 24+ or Arch Linux"
  ohai_err "Installation stopped."
  exit 1
fi
