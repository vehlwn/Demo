# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="candy-kingdom"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting command-time safe-paste)

DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true
source $ZSH/oh-my-zsh.sh

unsetopt BEEP

setopt APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS INC_APPEND_HISTORY SHARE_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

export PATH=$PATH:$HOME/.local/bin
export EDITOR=/usr/bin/nvim
export FZF_DEFAULT_COMMAND="find -L"
