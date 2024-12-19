ohai_section_begin "zsh"

ohai "Installing zsh configuration"

[ -f "~/.zshrc" ] && cp ~/.zshrc ~/.zshrc.bak
cp "$HOME/.local/share/devkit/configs/zshrc" "$HOME/.zshrc"

ohai_section_end "zsh"
