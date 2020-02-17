# Bytewave's .zshrc

# Prevent commands prefixed with space from being recorded by the shell history
setopt histignorespace

if [[ ! -d $HOME/.oh-my-zsh ]]; then
	echo "oh-my-zsh is not installed!"
	echo "Downloading and installing..."
	echo "Cloning oh-my-zsh..."
	git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

if [[ ! -d $HOME/.zplug ]]; then
	echo "zplug is not installed!"
	echo "Downloading and installing..."
	echo "Cloning zplug..."
	git clone https://github.com/zplug/zplug ~/.zplug
fi

if command -v code >/dev/null 2>&1; then
	export EDITOR="code --wait"
elif command -v vim >/dev/null 2>&1; then
	export EDITOR="vim"
else
	export EDITOR="nano"
fi

export VISUAL="$EDITOR"
export BROWSER="/usr/bin/google-chrome-stable"
export TERMINAL="termite"
export PAGER="less"

# temporary workaround for corrupted terminfo database
if [ $TERM = "xterm-256color" ]; then
	export TERM="xterm"
fi

if command -v luarocks >/dev/null 2>&1; then
	eval $(luarocks path --bin)
fi

if command -v go >/dev/null 2>&1; then
	export GOPATH="$(go env GOPATH)"
	export PATH="$GOPATH/bin:$PATH"
fi

export PATH="$HOME/bin:$PATH"

npm-exec () {
	(PATH=$(npm bin):$PATH; eval "$@")
}

export QT_STYLE_OVERRIDE="gtk"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export TZ=US/Central

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ys"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=()

### ZPLUG
source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'plugins/git', from:oh-my-zsh
zplug 'plugins/composer', from:oh-my-zsh
zplug 'plugins/colorize', from:oh-my-zsh
zplug 'plugins/yarn', from:oh-my-zsh
zplug 'plugins/ssh-agent', from:oh-my-zsh
zplug 'plugins/docker-compose', from:oh-my-zsh
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-completions', depth:1
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-history-substring-search', defer:3

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose
### END ZPLUG

zstyle :omz:plugins:ssh-agent identities gitlab aur github

# Reload completions
autoload -U compinit && compinit

# User configuration

source $ZSH/oh-my-zsh.sh

if [[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
	source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias nvimconfig="$EDITOR ~/.config/nvim/init.vim"
#alias i3config="$EDITOR ~/.config/i3/config"
alias neofetchconfig="$EDITOR ~/.config/neofetch/config"

alias tree="tree -C"
alias fortune="fortune | ponysay"
alias l="ls -lah --color"
alias ds="du --max-depth=1 -h"

if command -v thefuck >/dev/null 2>&1; then
	eval "$(thefuck --alias)"
fi

# Pretty man pages
man() {
	env \
	LESS_TERMCAP_mb=$'\e[01;31m' \
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	man "$@"
}

if command -v neofetch >/dev/null 2>&1; then
	alias clear="clear; neofetch"
	neofetch
fi
