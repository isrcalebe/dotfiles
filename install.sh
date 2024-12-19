#!/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Desktop software and tweaks will only be installed if we're running Gnome
RUNNING_GNOME=$([[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] && echo true || echo false)

DEVKIT_PATH="$HOME/.local/share/devkit"

# Check the distribution name and version and abort if incompatible
source "$HOME/.local/share/devkit/install/check-version.sh"
source "$HOME/.local/share/devkit/install/terminal/required/app-gum.sh" ">/dev/null"

if $RUNNING_GNOME; then
  # Ensure computer doesn't go to sleep or lock while installing
  gsettings set org.gnome.desktop.screensaver lock-enabled false
  gsettings set org.gnome.desktop.session idle-delay 0

  ohai "Get ready to make a few choices..."
  source "$HOME/.local/share/devkit/install/first-run-choices.sh"

  ohai "Installing terminal and desktop tools..."
else
  ohai "Only installing terminal tools..."
fi

# Install terminal tools
source "$HOME/.local/share/devkit/install/terminal.sh"

if $RUNNING_GNOME; then
  # Install desktop tools and tweaks
  source "$HOME/.local/share/devkit/install/desktop.sh"

  # Revert to normal idle and lock settings
  gsettings set org.gnome.desktop.screensaver lock-enabled true
  gsettings set org.gnome.desktop.session idle-delay 300
fi
