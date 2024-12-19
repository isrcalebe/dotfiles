ohai_section_begin "applications"

for script in ~/.local/share/devkit/applications/*.sh; do source $script; done

ohai_section_end "applications"
