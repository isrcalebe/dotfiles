#!/usr/bin/env bash

set -e

ascii_art='
██████╗ ███████╗██╗   ██╗██╗  ██╗██╗████████╗
██╔══██╗██╔════╝██║   ██║██║ ██╔╝██║╚══██╔══╝
██║  ██║█████╗  ██║   ██║█████╔╝ ██║   ██║
██║  ██║██╔══╝  ╚██╗ ██╔╝██╔═██╗ ██║   ██║
██████╔╝███████╗ ╚████╔╝ ██║  ██╗██║   ██║
╚═════╝ ╚══════╝  ╚═══╝  ╚═╝  ╚═╝╚═╝   ╚═╝
'

# string formatters
if [ -t 1 ]; then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_blue=$(tty_mkbold 34)
tty_gray=$(tty_mkbold 37)
tty_red=$(tty_mkbold 31)
tty_gold=$(tty_mkbold 33)
tty_green=$(tty_mkbold 32)
tty_bold=$(tty_escape 1)
tty_reset=$(tty_escape 0)

ohai() {
  printf "  ${tty_blue}${tty_bold}info ${tty_reset}${tty_gray}%s${tty_reset}\n" "$1"
}

ohai_warn() {
  printf "  ${tty_gold}${tty_bold}warn ${tty_reset}${tty_gray}%s${tty_reset}\n" "$1"
}

ohai_err() {
  printf "  ${tty_red}${tty_bold}error ${tty_reset}${tty_gray}%s${tty_reset}\n" "$1"
}

ohai_ok() {
  printf "  ${tty_green}${tty_bold}ok ${tty_reset}${tty_gray}%s${tty_reset}\n" "$1"
}

ohai_prompt() {
  read -r -p "  ${tty_blue}${tty_bold}prompt ${tty_reset}${tty_gray}$1${tty_reset}: " $2
}

echo -e "${tty_green}${tty_bold}$ascii_art${tty_reset}"
ohai "DevKit is for fresh Arch Linux or newer installations only!"
ohai "Begin installation (or abort with CTRL+C)..."

if [ "$EUID" -eq 0 ]; then
  ohai_err "Do not run this script as root. Use a regular user with sudo privileges."
  exit 1
fi

if ! sudo -v; then
  ohai_err "This script requires sudo privileges."
  exit 1
fi

if [ ! -f /etc/os-release ]; then
  ohai_err "$(tput setaf 1)Error: Unable to determine OS. /etc/os-release file not found."
  ohai_err "Installation stopped."
  exit 1
fi

. /etc/os-release

if [ "$ID" != "manjaro" ] && [ "$ID" != "arch" ]; then
  ohai_err "$(tput setaf 1)Error: OS requirement not met"
  ohai_err "You are currently running: $ID"
  ohai_err "OS required: Manjaro GNOME 24+ or Arch Linux"
  ohai_err "Installation stopped."
  exit 1
fi


check_chaotic_aur() {
  if grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
    return 0
  else
    return 1
  fi
}

enable_chaotic_aur() {
  ohai "Enabling Chaotic AUR..."

  sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key 3056513887B78AEB

  sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
  sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

  echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf > /dev/null

  pacman -Syy
}

report_paru() {
  ohai_warn "paru is not installed."
  ohai_prompt "Do you want to install paru? [Y/n]" response

  response=${response:-y}
  if [ "$response" = "y" ]; then
    if ! check_chaotic_aur; then
      enable_chaotic_aur
    fi

    ohai "Installing paru..."
    sudo pacman -S --noconfirm paru
  else
    ohai_err "paru is required for DevKit installation."
    exit 1
  fi

  if command -v paru >/dev/null 2>&1; then
    paru -Syyu --noconfirm
    ohai_ok "paru has been installed successfully."
  else
    ohai_err "paru installation failed."
    exit 1
  fi
}

command -v paru >/dev/null 2>&1 || report_paru
paru -Syyuu --noconfirm

ohai "Installing dependencies..."
#rm -rf "$HOME/.local/share/devkit"

# git clone https://github.com/isrcalebe/devkit.git $HOME/.local/share/devkit >/dev/null

# if [[ $DEVKIT_REF != "main" ]]; then
#   cd "$HOME/.local/share/devkit"
#   git fetch origin "${DEVKIT_REF:-stable}" && git checkout "${DEVKIT_REF:-stable}"
#   cd -
# fi

ohai "Installing DevKit..."
source "$HOME/.local/share/devkit/utils/ohai.sh"
source "$HOME/.local/share/devkit/install.sh"
