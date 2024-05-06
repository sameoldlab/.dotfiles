typeset -U path cdpath fpath manpath

# Use emacs keymap as the default.
bindkey -e

# Loading Antidote START
source ${ZDOTDIR}/antidote/antidote.zsh
zstyle ':antidote:bundle' use-friendly-names 'yes'
antidote load

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

typeset -gU path fpath
