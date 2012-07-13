#
# dotzsh : https://github.com/dotzsh/dotzsh
#
# Defines Rsync aliases.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

if (( ! $+commands[rsync] )); then
  return 2
fi

# Aliases
_rsync_cmd='rsync --verbose --progress --human-readable --compress --archive --hard-links --one-file-system'

# Mac OS X and HFS+ Enhancements
# http://www.bombich.com/rsync.html
if [[ "$OSTYPE" == darwin* ]] && grep -q 'file-flags' <(rsync --help 2>&1); then
  _rsync_cmd="${_rsync_cmd} --crtimes --acls --xattrs --fileflags --protect-decmpfs --force-change"
fi

alias rsync-copy="${_rsync_cmd}"
alias rsync-move="${_rsync_cmd} --remove-source-files"
alias rsync-update="${_rsync_cmd} --update"
alias rsync-synchronize="${_rsync_cmd} --update --delete"

unset _rsync_cmd
