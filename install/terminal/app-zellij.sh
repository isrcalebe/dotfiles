ohai_section_begin "zellij"

paru -S --needed zellij --noconfirm

mkdir -p "$HOME/.config/zellij/themes"

[ ! -f "$HOME/.config/zellij/config.kdl" ] && cp "$HOME/.local/share/devkit/configs/zellij.kdl" "$HOME/.config/zellij/config.kdl"

cp "$HOME/.local/share/devkit/configs/zellij/themes/tokyo-night.kdl" "$HOME/.config/zellij/themes/tokyo-night.kdl"

ohai_section_end "zellij"
