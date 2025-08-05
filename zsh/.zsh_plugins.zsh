fpath+=( /home/ibro/.cache/antidote/mattmc3/ez-compinit )
source /home/ibro/.cache/antidote/mattmc3/ez-compinit/ez-compinit.plugin.zsh
fpath+=( /home/ibro/.cache/antidote/zsh-users/zsh-completions )
source /home/ibro/.cache/antidote/zsh-users/zsh-completions/zsh-completions.plugin.zsh
if ! (( $+functions[zsh-defer] )); then
  fpath+=( /home/ibro/.cache/antidote/romkatv/zsh-defer )
  source /home/ibro/.cache/antidote/romkatv/zsh-defer/zsh-defer.plugin.zsh
fi
fpath+=( /home/ibro/.cache/antidote/aloxaf/fzf-tab )
zsh-defer source /home/ibro/.cache/antidote/aloxaf/fzf-tab/fzf-tab.plugin.zsh
fpath+=( /home/ibro/.cache/antidote/mattmc3/zephyr/plugins/color )
zsh-defer source /home/ibro/.cache/antidote/mattmc3/zephyr/plugins/color/color.plugin.zsh
fpath+=( /home/ibro/.cache/antidote/mroth/evalcache )
source /home/ibro/.cache/antidote/mroth/evalcache/evalcache.plugin.zsh
source $ZDOTDIR/aliases
source $ZDOTDIR/exports
source $ZDOTDIR/plugins/history.zsh
source $ZDOTDIR/plugins/dirstack.zsh
source $ZDOTDIR/plugins/editor.zsh
fpath+=( /home/ibro/.cache/antidote/zdharma-continuum/fast-syntax-highlighting )
zsh-defer source /home/ibro/.cache/antidote/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fpath+=( /home/ibro/.cache/antidote/zsh-users/zsh-autosuggestions )
zsh-defer source /home/ibro/.cache/antidote/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
