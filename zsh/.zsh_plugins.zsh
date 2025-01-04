fpath+=( /home/ibro/.cache/antidote/mattmc3/zephyr/plugins/completion )
source /home/ibro/.cache/antidote/mattmc3/zephyr/plugins/completion/completion.plugin.zsh
fpath+=( /home/ibro/.cache/antidote/mattmc3/zephyr/plugins/color )
source /home/ibro/.cache/antidote/mattmc3/zephyr/plugins/color/color.plugin.zsh
source $ZDOTDIR/aliases
source $ZDOTDIR/exports
source $ZDOTDIR/plugins/history.zsh
if ! (( $+functions[zsh-defer] )); then
  fpath+=( /home/ibro/.cache/antidote/romkatv/zsh-defer )
  source /home/ibro/.cache/antidote/romkatv/zsh-defer/zsh-defer.plugin.zsh
fi
zsh-defer source $ZDOTDIR/plugins/fzf-tab-completions.zsh
source $ZDOTDIR/plugins/dirstack.zsh
source $ZDOTDIR/plugins/editor.zsh
fpath+=( /home/ibro/.cache/antidote/belak/zsh-utils/completion )
source /home/ibro/.cache/antidote/belak/zsh-utils/completion/completion.plugin.zsh
fpath+=( /home/ibro/.cache/antidote/Aloxaf/fzf-tab )
source /home/ibro/.cache/antidote/Aloxaf/fzf-tab/fzf-tab.plugin.zsh
fpath+=( /home/ibro/.cache/antidote/zdharma-continuum/fast-syntax-highlighting )
zsh-defer source /home/ibro/.cache/antidote/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fpath+=( /home/ibro/.cache/antidote/zsh-users/zsh-autosuggestions )
zsh-defer source /home/ibro/.cache/antidote/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fpath+=( /home/ibro/.cache/antidote/zsh-users/zsh-history-substring-search )
zsh-defer source /home/ibro/.cache/antidote/zsh-users/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
