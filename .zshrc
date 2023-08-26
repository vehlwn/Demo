autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' matcher-list \
    '' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
    'l:|=* r:|=*'

source ~/.zsh/aliases.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/key-bindings.zsh
source ~/.zsh/options.zsh
source ~/.zsh/prompt.zsh

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# zsh-users/zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_PREFIXED=1

source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

typeset -U path
path=($path "${HOME}/.local/bin")
