#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#
typeset -U path cdpath fpath manpath

# Use emacs keymap as the default.
bindkey -e

# Loading Antidote START
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
  source ${ZDOTDIR}/antidote/antidote.zsh
  zstyle ':antidote:bundle' use-friendly-names 'yes'
  antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
)
fi
source ${zsh_plugins}.zsh


# # Called before prompt(?)
function precmd {
    # Set window title
    print -Pn "\e]0;zsh%L %(1j,%j job%(2j|s|); ,)%\e\\"
}

# # Called when executing a command
function preexec {
    print -Pn "\e]0;${(q)1}\e\\"
}

function current_dir() {
  local current_dir=$PWD
  if [[ $current_dir == $HOME ]]; then
      current_dir="~"
  else
      current_dir=${current_dir##*/}
  fi

  echo $current_dir
}

function change_tab_title() {
  local title=$1
  command nohup zellij action rename-tab $title >/dev/null 2>&1
}

function set_tab_to_working_dir() {
  local result=$?
  local title=$(current_dir)
  # uncomment the following to show the exit code after a failed command
  if [[ $result -gt 0 ]]; then
      title="$title [$result]" 
  fi

  change_tab_title $title
}

function set_tab_to_command_line() {
  local cmdline=$1
  change_tab_title $cmdline
}

if [[ -n $ZELLIJ ]]; then
    add-zsh-hook precmd set_tab_to_working_dir
    add-zsh-hook preexec set_tab_to_command_line
fi

setopt extendedglob
unsetopt BEEP
zle_highlight=('paste:none')

typeset -Ag abbreviations=(
  # Whenever I type 'Gc' followed by space, replace
  # that with 'git commit -m ""' with the cursor between
  # the double quotes.
  'Gc' 'git commit -m "__CURSOR__"'
  # 'gs' 'git status -uno'
)

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    command=${abbreviations[$MATCH]}
    LBUFFER+=${command:-$MATCH}

    if [[ "${command}" =~ "__CURSOR__" ]]
    then
        RBUFFER=${LBUFFER[(ws:__CURSOR__:)2]}
        LBUFFER=${LBUFFER[(ws:__CURSOR__:)1]}
    else
        zle self-insert
    fi
}
no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
bindkey -M isearch " " self-insert

eval "$(starship init zsh)"  
eval "$(zoxide init zsh)"  
eval "$(fzf --zsh)"
eval "$(atuin init zsh)"
eval "$(direnv hook zsh)"

typeset -gU path fpath
