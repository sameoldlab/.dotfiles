#!/usr/bin/zsh
#
# zsh aliases
#

HISTSIZE="50000"
SAVEHIST="50000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE # Do not record an event starting with a space.
unsetopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt SHARE_HISTORY 
unsetopt EXTENDED_HISTORY # Write the history file in the ':start:elapsed;command' format.
setopt autocd 
