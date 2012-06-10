# Fix up 256color support in tmux and vim
if ! { [ "$TMUX" = "" ]; } then
    export TERM=screen-256color
else
    if ! { [ "$TERM" = "linux" ]; } then
        export TERM=xterm-256color
    fi
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ah"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias o="open"


# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git compleat extract git-flow history-substring-search macports osx)

if [[ -e /opt/local/bin/gdircolors ]]; then
    alias dircolors=/opt/local/bin/gdircolors
fi

if [[ -e $HOME/.dir_colors ]]; then
    eval $(dircolors -b $HOME/.dir_colors)
    export LS_COLORS
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

source $ZSH/oh-my-zsh.sh

unsetopt SHARE_HISTORY

alias ls="ls --color=auto --group-directories-first"
if [[ -e /opt/local/bin/gls ]]; then
    alias ls="/opt/local/bin/gls --color=auto --group-directories-first"
fi


if [[ -e $HOME/.zshrc.local ]]; then
    source $HOME/.zshrc.local
fi
