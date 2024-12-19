ohai "Installing VirtualBox..."

paru -S --needed virtualbox virtualbox-ext-oracle --noconfirm
sudo usermod -aG vboxusers ${USER}
newgrp vboxusers
