ohai_section_begin "docker"

paru -S --needed --noconfirm docker docker-compose

sudo usermod -aG docker $USER

sudo mkdir -p /etc/docker
if [ -f /etc/docker/daemon.json ]; then
  sudo jq -s '.[0] * .[1]' "/etc/docker/daemon.json" "$HOME/.local/share/devkit/configs/docker.json"
else
  sudo cp "$HOME/.local/share/devkit/configs/docker.json" "/etc/docker/daemon.json"
fi

sudo systemctl restart docker.service
sudo systemctl enable docker.service
ohai "Docker daemon started"

newgrp docker <<<''

ohai_section_end "docker"
