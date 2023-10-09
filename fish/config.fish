if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -x NVM_DIR ~/.nvm
nvm use default --silent

starship init fish | source
zoxide init fish | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/ibro/miniconda3/bin/conda
    eval /home/ibro/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

