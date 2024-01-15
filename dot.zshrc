# Defaults
export EDITOR=vim
export PAGER=less

# Locale
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"

# Aliases
alias rm='rm -iv'
alias ls='ls -F --color=auto'

alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gap='git add -p'
alias gl='git log'
alias gpr='git pull --rebase'

# These are new times; old muscle memory
alias vi=vim
alias ack=rg

# History
HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=1000
setopt histignorealldups
setopt -o sharehistory
setopt inc_append_history

# Shortcuts
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Disable ^S and ^Z freezing
unsetopt flowcontrol

# Programming environments
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Completion
if [ "$commands[kubectl]" ]; then
  alias k=kubectl
  source <(kubectl completion zsh)
fi

zstyle :compinstall filename '/home/simon/.zshrc'
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

if [ "$commands[rustup]" -a ! -e ~/.zfunc/_rustup ]; then
  mkdir -p ~/.zfunc
  rustup completions zsh > ~/.zfunc/_rustup
  fpath+=~/.zfunc
fi

[ -f "/usr/bin/aws_zsh_completer.sh" ] && source /usr/bin/aws_zsh_completer.sh

# Highlighting
zsh_syn=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [ -e "$zsh_syn" ]; then
  source "$zsh_syn"
fi

# git prompt
# export PS1='%~ $ '
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PROMPT='[%n@%M %y] '\$vcs_info_msg_0_': %~'$'\n''%(!.#.$) '
PROMPT='%F{green}[%n@%M %y]%f %F{red}'\$vcs_info_msg_0_'%f %F{blue}%~%f'$'\n''%F{green}%(!.#.$)%f '
PROMPT='%B%F{green}%n@%M%f%b:%F{blue}%~%f %F{red}'\$vcs_info_msg_0_'%f %(!.#.$) '
zstyle ':vcs_info:git:*' formats '%b'

# Programming Environments
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="/opt/aarch64-linux-musl-cross/bin:$PATH"

[ -f "/home/sshine/.ghcup/env" ] && source "/home/sshine/.ghcup/env" # ghcup-env
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
