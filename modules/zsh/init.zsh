#!/usr/bin/env zsh

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

PROFILE_REAL_TARGET="$(dirname $(readlink -f ${0:a}) )"

autoload -U +X compinit \
&& compinit
autoload -U +X bashcompinit \
&& bashcompinit

use_scripts() {
  files=($(find "$1" -maxdepth 1 -type f -name "*.zsh" ! -iname "init.zsh"))

  for file in $files
  do
    source $file
  done

  unset files
}

pushd $PROFILE_REAL_TARGET >/dev/null

use_scripts "."

popd >/dev/null

autoload -U +X zicompinit \
&& zicompinit
