autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select

source ~/.zsh/aliases.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/key-bindings.zsh
source ~/.zsh/options.zsh
source ~/.zsh/prompt.zsh

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

typeset -U path
path=($path "${HOME}/.local/bin")
