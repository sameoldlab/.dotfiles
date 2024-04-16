typeset -U path cdpath fpath manpath

# Use emacs keymap as the default.
bindkey -e


# Loading Antidote START
source ${ZDOTDIR}/antidote/antidote.zsh
antidote load

# autoload -U compinit && compinit


# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="50000"
SAVEHIST="50000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY
setopt autocd

			
# Configure fzf-tab https://github.com/Aloxaf/fzf-tab#configure
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1 $realpath'
zstyle ':fzf-tab:complete:zi:*' fzf-preview 'eza -1 $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'


# shortcuts
# ctrl+del:   ^[[3;5~     alt+del:   ^[[3;3~          
# CTRL: ^[[1;5
# ALT: ^[[1;3

# Left:   ^[[D + CRTL: ^[[1;5D 
# Right:  ^[[C + CRTL: ^[[1;5C 
# Up:     ^[[A + CRTL: ^[[1;5A 
# Down:   ^[[B + CRTL: ^[[1;5B     


bindkey '^[[A'   	history-substring-search-up
bindkey '^[[B'   	history-substring-search-down

bindkey '^[[3~'  	delete-char 
bindkey '^[[3;3~'  	kill-line
bindkey '^H'     	backward-kill-word
bindkey '^[[3;5~'	kill-word

        # Faster navigation (kitty / zsh took vimmotions already)
bindkey '^[[H'   	beginning-of-line #FN L / Home
bindkey '^[[F'   	end-of-line 			#FN R / End
bindkey '^[[1;5D'	backward-word			#CTRL L
bindkey '^[[1;5C' forward-word			#CTRL R
# bindkey '^[[1;5A'	  								#CTRL U
# bindkey '^[[1;5B'     							#CTRL D
# bindkey '^[[200~' ]] yank

# rerun with sudo
#ALT + S
zstyle ':fzf-tab:*' continuous-trigger '/'

# it is an example. you can change it
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
    'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
    'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
    'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
    'case "$group" in
    "commit tag") git show --color=always $word ;;
    *) git show --color=always $word | delta ;;
    esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
    'case "$group" in
    "modified file") git diff $word | delta ;;
    "recent commit object name") git show --color=always $word | delta ;;
    *) git log --color=always $word ;;
    esac'

# Set up Directory Stacks https://zsh.sourceforge.io/Intro/intro_6.html
# https://www.reddit.com/r/zsh/comments/ka4sae/comment/gf97h9v/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

DIRSTACKSIZE=8
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_MINUS PUSHD_SILENT PUSHD_TO_HOME

function my-redraw-prompt() {
{
    builtin echoti civis
    builtin local f
    for f in chpwd precmd; do
        "$f" &>/dev/null || builtin true
    done
    builtin zle reset-prompt
    } always {
        builtin echoti cnorm
    }
}

function my-cd-rotate() {
() {
    builtin emulate -L zsh
    while (( $#dirstack )) && ! builtin pushd -q $1 &>/dev/null; do
        builtin popd -q $1
    done
        (( $#dirstack ))
    } "$@" && my-redraw-prompt
}

function my-cd-up()      { builtin cd -q .. && my-redraw-prompt; }
function my-cd-back()    { my-cd-rotate +1; }
function my-cd-forward() { my-cd-rotate -0; }

zle -N my-cd-up
zle -N my-cd-back
zle -N my-cd-forward

bindkey '^[[1;3A' my-cd-up
bindkey '^[[1;3D' my-cd-back
bindkey '^[[1;3C' my-cd-forward

setopt extendedglob


## Aliases
setopt extendedglob
typeset -Ag abbreviations=(
  # Whenever I type 'Gc' followed by space, replace
  # that with 'git commit -m ""' with the cursor between
  # the double quotes.
  'Gc' 'git commit -m "__CURSOR__"'
)

# alias ls = "eza"
alias np="pnpm"
alias npd="pnpm dev"
alias hx="helix"
alias ll="eza --hyperlink -la"
alias SS="sudo !!"

alias Pa="sudo pacman"
alias Pup="sudo pacman"
alias Prm="sudo pacman"

alias Gup="git push"
alias Ga="git add"
alias Gs="git status"

alias zj="zellij"
alias fzfp="fzf --preview 'bat --style=numbers --color=always {}'"
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,dist"
export FZF_DEFAULT_COMMAND='fd --type file --hidden'
export FZF_CTRL_T_COMMAND="fd"
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_COMMAND="fd --type d --no-ignore-vcs --exclude node_modules --exclude .git"
export FZF_ALT_C_OPTS="
    --preview 'dust -D {}'
"

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

export EDITOR="helix"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export CARGO_HOME="$HOME/.cargo"
# Add to PATH
export PATH="$PATH:/home/ibro/.foundry/bin:/usr/local/cuda-12.2/bin:$PNPM_HOME:$CARGO_HOME/bin"
export GPG_TTY=/dev/pts/0
