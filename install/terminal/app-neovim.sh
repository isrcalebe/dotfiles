ohai_section_begin "neovim"

paru -S --needed --noconfirm neovim

install_neovim() {
  git clone https://github.com/isrcalebe/neovim "$HOME/.config/nvim"

  sed -i 's/checker = { enabled = true }/checker = { enabled = true, notify = false }/g' "$HOME/.config/nvim/lua/config/lazy.lua"

  mkdir -p "$HOME/.config/nvim/plugin/after"

  cp "$HOME/.local/share/devkit/configs/neovim/transparency.lua" "$HOME/.config/nvim/plugin/after/"

  if [[ -d ~/.local/share/applications ]]; then
    sudo rm -rf "/usr/share/applications/nvim.desktop"
    source "$HOME/.local/share/devkit/applications/Neovim.sh"
  fi

  ohai_ok "Neovim configuration has been set up successfully."
}

if [ -d "$HOME/.config/nvim" ]; then
  ohai_warn "A configuration directory for neovim already exists."
  ohai_prompt "Would you like to backup the existing configuration and replace it with the default configuration? [Y/n]" response

  response=${response:-y}
  if [ "$response" = "y" ]; then
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
    install_neovim
  else
    ohai_warn "Skipping neovim configuration setup."
  fi
else
  ohai "Setting up neovim configuration..."

  install_neovim
fi

ohai_section_end "neovim"
