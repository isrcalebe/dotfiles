cat <<EOF >~/.local/share/applications/Neovim.desktop
[Desktop Entry]
Version=$(cat /home/$USER/.local/share/devkit/version)
Name=Neovim
Comment=Edit text files
Exec=alacritty --config-file /home/$USER/.local/share/devkit/defaults/alacritty/pane.toml --class=Neovim --title=Neovim -e nvim %F
Terminal=false
Type=Application
Icon=nvim
Categories=Utilities;TextEditor;
StartupNotify=false
EOF
