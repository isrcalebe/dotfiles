ohai_section_begin "lazydocker"

if ![ pacman -Q fakeroot-tcp ] &>/dev/null; then
  sudo pacman -S --needed fakeroot
fi

paru -S --needed lazydocker-bin --noconfirm

ohai_section_end "lazydocker"
