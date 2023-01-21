autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select
prompt adam1

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

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

unsetopt BEEP
setopt APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS INC_APPEND_HISTORY SHARE_HISTORY CORRECT

typeset -U path
path=($path "${HOME}/.local/bin")

export EDITOR=/usr/bin/nvim
export FZF_DEFAULT_COMMAND="find -L"
export DXVK_HUD=fps,memory,gpuload,api
export GTK_USE_PORTAL=1

alias sudo='sudo --validate && sudo '
alias l='ls -lah --color=auto --group-directories-first --classify'
alias ip='command ip -color=auto'
