if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -x NVM_DIR ~/.nvm
nvm use default --silent

starship init fish | source
zoxide init fish | source
