#!/usr/bin/env zsh

## ZI installer ##
if [[ ! -f "$HOME/.zi/bin/zi.zsh" ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" \
  && print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" \
  || print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
##################

## ZI import ##
source "$HOME/.zi/bin/zi.zsh"
###############

## ZI helpers ##
__zi_lucid() { zi ice lucid "$@"; }

__zi_0a() { __zi_lucid wait"0a" "$@"; }
__zi_0b() { __zi_lucid wait"0b" "$@"; }
__zi_0c() { __zi_lucid wait"0c" "$@"; }

__zi_completion() { __zi_0a as"completion" blockf "$@" }
__zi_program() { __zi_0a as"program" "$@" }
__zi_command() { __zi_0a as "command" "$@" }
__zi_turbo() { zi depth"3" lucid ${1/#[0-9][a-d]/wait"${1}"} "${@:2}" }
################

## Plugins ##

zi light-mode for z-shell/z-a-meta-plugins \
@annexes @console-tools @zsh-users+fast @z-shell

__zi_turbo "0a" for \
OMZL::git.zsh OMZL::functions.zsh

__zi_turbo "0b" for \
OMZL::clipboard.zsh OMZL::termsupport.zsh \
OMZL::directories.zsh

__zi_turbo "1a" for \
atload"unalias grv g" OMZP::git \
OMZP::sudo OMZP::common-aliases \
OMZP::systemd OMZP::aliases \
OMZP::asdf OMZP::yarn

__zi_completion
zi snippet OMZP::docker/completions/_docker

__zi_turbo "1b" for \
akarzim/zsh-docker-aliases alexdesousa/hab nekofar/zsh-git-flow-avh \
pick"autopair.zsh" hlissner/zsh-autopair \
atload"export ZSH_PLUGINS_ALIAS_TIPS_TEXT=\"💡\"" djui/alias-tips

__zi_completion pick"/dev/null" multisrc"src/go src/zsh"
zi light zchee/zsh-completions

__zi_program pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX"
zi light tj/git-extras

zi snippet "${0:a:h}/snippets/gnupg-as-ssh.zsh"

zi ice from'gh-r' as'program' sbin'**/eza -> eza' atclone'cp -vf completions/eza.zsh _eza'
zi light eza-community/eza

zi ice wait lucid has'eza' atinit'AUTOCD=1'
zi light z-shell/zsh-eza

zi ice as"command" from"gh-r" \
atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
atpull"%atclone" src"init.zsh"
zi light starship/starship
