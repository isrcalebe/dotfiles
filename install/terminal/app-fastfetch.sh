ohai_section_begin "fastfetch"

paru -S --needed fastfetch --noconfirm

if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  mkdir -p "$HOME/.config/fastfetch"
  cp "$HOME/.local/share/devkit/configs/fastfetch.jsonc" "$HOME/.config/fastfetch/config.jsonc"
fi

ohai_section_end "fastfetch"
