# Simon Shine <shine@diku.dk> .zshrc
export PS1='%j %~ $ '

export PATH=/home/simon/.cabal/bin:$PATH
export PATH=/home/simon/bin:$PATH
export XMODIFIERS='' # export XMODIFIERS='@im=ibus' breaks Emacs

setopt histignorealldups
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000

bindkey -e

zstyle :compinstall filename '/home/simon/.zshrc'

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

unsetopt flowcontrol # Disable ^S and ^Z freezing

alias rm='rm -iv'
alias cpx='rsync -v --progress'
alias grep='grep --color=auto'

# Key bindings
bindkey "^[[7~" beginning-of-line #Home key
bindkey "^[[8~" end-of-line #End key
bindkey "^[[3~" delete-char #Del key
bindkey "^[[A" history-beginning-search-backward #Up Arrow
bindkey "^[[B" history-beginning-search-forward #Down Arrow
bindkey "^[Oc" forward-word # control + right arrow
bindkey "^[Od" backward-word # control + left arrow
bindkey "^H" backward-kill-word # control + backspace
bindkey "^[[3^" kill-word # control + delete

bindkey '^[[5D' backward-word
bindkey '^[[5C' forward-word
bindkey ';5D' backward-word
bindkey ';5C' forward-word

# Completion
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
