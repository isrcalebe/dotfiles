# string formatters
if [ -t 1 ]; then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi
tty_mkbg() { tty_escape "48;5;$1"; }

tty_mkbold() { tty_escape "1;$1"; }
tty_blue=$(tty_mkbold 34)
tty_gray=$(tty_mkbold 37)
tty_red=$(tty_mkbold 31)
tty_gold=$(tty_mkbold 33)
tty_green=$(tty_mkbold 32)
tty_bold=$(tty_escape 1)
tty_secondary_bg=$(tty_mkbg 238)
tty_reset=$(tty_escape 0)

ohai() {
  printf "  ${tty_blue}${tty_bold}info ${tty_reset}${tty_gray}%s${tty_reset}\n" "$1"
}

ohai_warn() {
  printf "  ${tty_gold}${tty_bold}warn ${tty_reset}${tty_gray}%s${tty_reset}\n" "$1"
}

ohai_err() {
  printf "  ${tty_red}${tty_bold}error ${tty_reset}${tty_gray}%s${tty_reset}\n" "$1"
}

ohai_ok() {
  printf "  ${tty_green}${tty_bold}ok ${tty_reset}${tty_gray}%s${tty_reset}\n" "$1"
}

ohai_prompt() {
  read -r -p "  ${tty_blue}${tty_bold}prompt ${tty_reset}${tty_gray}$1${tty_reset}: " $2
}

ohai_section_begin() {
  local section="$1"
  local length=${#section}
  local spaces=""

  printf -v spaces '%*s' "$length"

  printf "\n  ${tty_secondary_bg}  %s         ${tty_reset}\n" "$spaces"
  printf "  ${tty_secondary_bg}  ${tty_gold}%s  ${tty_reset}${tty_secondary_bg}${tty_blue}begin  ${tty_reset}\n" "$section"
  printf "  ${tty_secondary_bg}  %s         ${tty_reset}\n\n" "$spaces"
}

ohai_section_end() {
  local section="$1"
  local length=${#section}
  local spaces=""

  printf -v spaces '%*s' "$length"

  printf "\n  ${tty_secondary_bg}  %s         ${tty_reset}\n" "$spaces"
  printf "  ${tty_secondary_bg}  ${tty_gold}%s    ${tty_reset}${tty_secondary_bg}${tty_blue}end  ${tty_reset}\n" "$section"
  printf "  ${tty_secondary_bg}  %s         ${tty_reset}\n\n" "$spaces"
}
