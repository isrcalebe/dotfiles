ohai_section_begin "development languages"

if [[ -v DEVKIT_FIRST_RUN_LANGUAGES ]]; then
  languages=$DEVKIT_FIRST_RUN_LANGUAGES
else
  AVAILABLE_LANGUAGES=("Node.js" "Go" ".NET" "PHP" "Python" "Elixir" "Rust" "Java")
  languages=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --height 10 --header "Select programming languages")
fi

if [[ -n "$languages" ]]; then
  for language in $languages; do
    case $language in
    Node.js)
      ohai "Installing Node.js"
      mise use --global node@latest
      ;;
    Go)
      ohai "Installing Go"
      mise use --global go@latest
      ;;
    PHP)
      ohai "Installing PHP"
      paru -Sy --noconfirm php
      php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
      php composer-setup.php --quiet && sudo mv "composer.phar" "/usr/local/bin/composer"
      rm "composer-setup.php"
      ;;
    Python)
      ohai "Installing Python"
      mise use --global python@latest
      ;;
    Elixir)
      ohai "Installing Elixir and Erlang"
      mise use --global erlang@latest
      mise use --global elixir@latest
      mise x elixir -- mix local.hex --force
      ;;
    Rust)
      ohai "Installing Rust"
      default_toolchain="stable"
      default_profile="default"

      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain "$default_toolchain" --profile "$default_profile" --no-modify-path
      ;;
    Java)
      ohai "Installing Java"
      mise use --global java@latest
      ;;
    esac
  done
fi

ohai_section_end "development languages"
