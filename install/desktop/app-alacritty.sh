ohai_section_begin "alacritty"

# Alacritty is a GPU-powered and highly extensible terminal. See https://alacritty.org/
paru -S --needed alacritty --noconfirm

mkdir -p ~/.config/alacritty
cp "$HOME/.local/share/devkit/configs/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
cp "$HOME/.local/share/devkit/configs/alacritty/theme.toml" "$HOME/.config/alacritty/theme.toml"
cp "$HOME/.local/share/devkit/configs/alacritty/fonts/CaskaydiaMono.toml" "$HOME/.config/alacritty/font.toml"
cp "$HOME/.local/share/devkit/configs/alacritty/font-size.toml" "$HOME/.config/alacritty/font-size.toml"

ohai_section_end "alacritty"
