#!/usr/bin/env zsh

unset SSH_AGENT_PID

[[ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]] \
&& export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

export GPG_TTY=$(tty)

gpg-connect-agent --quiet updatestartuptty /bye >/dev/null
