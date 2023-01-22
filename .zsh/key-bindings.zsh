# emacs mode
bindkey -e

# setup key accordingly:
# home
bindkey "^[[1~" beginning-of-line
# end
bindkey "^[[4~" end-of-line
# delete
bindkey "^[[3~" delete-char
# left
bindkey "^[[D" backward-char
# right
bindkey "^[[C" forward-char
# shift+tab
bindkey "^[[Z" reverse-menu-complete
# control+left
bindkey '^[[1;5C' forward-word
# control+right
bindkey '^[[1;5D' backward-word
# zsh-users/zsh-history-substring-search keys:
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
