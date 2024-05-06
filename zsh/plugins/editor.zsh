#
# Editor - keybinds for editinng text that I'm used to
#
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
