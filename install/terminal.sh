# Needed for all installers
sudo pacman -Syyuu --noconfirm
sudo pacman -S --needed curl git unzip --noconfirm

# Run terminal installers
for installer in ~/.local/share/devkit/install/terminal/*.sh; do source $installer; done

ohai_ok "Finished installing all Terminal-based apps and configurations. Log out and log back in."
