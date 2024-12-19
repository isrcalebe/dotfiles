cat <<EOF >~/.local/share/applications/Docker.desktop
[Desktop Entry]
Version=$(cat /home/$USER/.local/share/devkit/version)
Name=Docker
Comment=Manage Docker containers with LazyDocker
Exec=alacritty --config-file /home/$USER/.local/share/devkit/defaults/alacritty/pane.toml --class=Docker --title=Docker -e lazydocker
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/devkit/applications/icons/Docker.png
Categories=GTK;
StartupNotify=false
EOF
