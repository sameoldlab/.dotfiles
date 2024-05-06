
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

