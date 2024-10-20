# Bytewave's .zshrc

# Prevent commands prefixed with space from being recorded by the shell history
setopt histignorespace

host_platform="$(uname -s)"
is_macos="$([ "$host_platform" = "Darwin" ] && echo true)"
is_wsl="$(grep -i 'wsl' /proc/version > /dev/null && echo true)"

if [ "$is_macos" = true ]; then
	if [ -d /opt/homebrew ]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
		FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
	fi

	export GPG_TTY="$(tty)"
	export BROWSER="open"
fi

if [ "$is_wsl" = true ]; then
	export BROWSER="wslview"
fi

if [[ ! -d $HOME/.oh-my-zsh ]]; then
	echo "oh-my-zsh is not installed!"
	echo "Downloading and installing..."
	echo "Cloning oh-my-zsh..."
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
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
export PAGER="less"

zstyle ':omz:plugins:nvm' autoload yes

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

npm-exec () {
	(PATH=$(npm bin):$PATH; eval "$@")
}

export QT_STYLE_OVERRIDE="gtk"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export TZ=America/Toronto

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
zplug 'plugins/colored-man-pages', from:oh-my-zsh
zplug 'plugins/command-not-found', from:oh-my-zsh
zplug 'plugins/docker-compose', from:oh-my-zsh
zplug 'plugins/fzf', from:oh-my-zsh
zplug 'plugins/gh', from:oh-my-zsh
zplug 'plugins/git', from:oh-my-zsh
if [ "$is_macos" = true ]; then
	zplug 'plugins/macos', from:oh-my-zsh
fi
zplug 'plugins/nvm', from:oh-my-zsh
zplug 'plugins/ssh-agent', from:oh-my-zsh
zplug 'plugins/rails', from:oh-my-zsh
zplug 'plugins/rbenv', from:oh-my-zsh
zplug 'plugins/yarn', from:oh-my-zsh
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions', depth:1
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
# zplug 'zsh-users/zsh-history-substring-search', defer:3

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
### END ZPLUG

zstyle :omz:plugins:sshagent agent-forwarding yes
zstyle :omz:plugins:ssh-agent identities id_ed25519_sk_rk_28ad202d7ae076cf6cd3b3a07464161a3ccca407e2bb037926fe98c00e43e702

if [ "$is_wsl" = true ]; then
	if [ -f /usr/lib/libwindowsfidobridge.so ]; then
		zstyle :omz:plugins:ssh-agent ssh-add-args -S /usr/lib/libwindowsfidobridge.so
	fi
fi

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
alias vimconfig="$EDITOR ~/.vimrc"

alias tree="tree -C"
alias fortune="fortune | ponysay"
alias l="ls -lahF --color"
alias ds="du --max-depth=1 -h"

if command -v fastfetch >/dev/null 2>&1; then
	alias clear="clear; fastfetch"
	fastfetch
fi

if [ "$is_macos" = true ]; then
	[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
fi
