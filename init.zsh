#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Initializes dotzsh.
#
# Authors:
#   Robby Russell <robby@planetargon.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

if [ -z "${DOTZSHLOCAL}" ]; then
 export DOTZSHLOCAL="$DOTZSH.local"
fi

# Check for the minimum supported version.
min_zsh_version='4.2.6'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  print "dotzsh: old shell detected, minimum required: $min_zsh_version" >&2
  return 9
fi
unset min_zsh_version

# Disable color and theme in dumb terminals.
if [[ "$TERM" == 'dumb' ]]; then
  zstyle ':dotzsh:*:*' color 'no'
  zstyle ':dotzsh:module:prompt' theme 'off'
fi

# Load Zsh modules.
zstyle -a ':dotzsh:load' zmodule 'zmodules'
for zmodule ("$zmodules[@]") zmodload "zsh/${(z)zmodule}"
unset zmodule{s,}

# Autoload Zsh functions.
zstyle -a ':dotzsh:load' zfunction 'zfunctions'
for zfunction ("$zfunctions[@]") autoload -Uz "$zfunction"
unset zfunction{s,}

# Source files (the order matters).
source "${0:h}/helper.zsh"

# Source modules defined in ~/.zshrc.
zstyle -a ':dotzsh:load' dzmodule 'dzmodules'
dzmodload "$dzmodules[@]"
unset dzmodules

