#
# dotzsh : https://github.com/dotzsh/dotzsh
#
# Provides for an easier use of gpg-agent.
#
# Authors:
#   Florian Walch <florian.walch@gmx.at>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

if (( ! $+commands[gpg-agent] )); then
  return 2
fi

_gpg_env="$HOME/.gnupg/gpg-agent.env"

function _gpg-agent-start {
  gpg-agent --daemon --write-env-file "${_gpg_env}" > /dev/null
  chmod 600 "${_gpg_env}"
  source "${_gpg_env}" > /dev/null
}

# Source GPG agent settings, if applicable.
if [[ -s "${_gpg_env}" ]]; then
  source "${_gpg_env}" > /dev/null
  ps -ef | grep "${SSH_AGENT_PID}" | grep -q 'gpg-agent' || {
    _gpg-agent-start
  }
else
  _gpg-agent-start
fi

export GPG_AGENT_INFO
export SSH_AUTH_SOCK
export SSH_AGENT_PID
export GPG_TTY="$(tty)"

alias gpgas='gpg --export -a'
alias gpgh='gpg --help|$PAGER'
alias gpgks='gpg --search-keys'
alias gpgl='gpg --list-keys --with-fingerprint'
alias gpgkS='gpg --sign-key'
alias gpgls='gpg --list-sigs'
alias gpgen='gpg -e -r $1 $2'
alias gpgde='gpg -d $1'
alias gpgrk='gpg --recv-keys $1'
alias gpgcl='gpg --clearsign $1'
alias gpgfp='gpg --fingerprint $1'
alias gpgsk='gpg --send-keys $1'
