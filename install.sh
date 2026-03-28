#!/usr/bin/env bash

echo -e "\033[0;34m"

cat << "EOF"
              __          __       ___      ___                    
             /\ \        /\ \__  /'___\ __ /\_ \                   
             \_\ \    ___\ \ ,_\/\ \__//\_\\//\ \      __    ____  
             /'_` \  / __`\ \ \/\ \ ,__\/\ \ \ \ \   /'__`\ /',__\ 
            /\ \L\ \/\ \L\ \ \ \_\ \ \_/\ \ \ \_\ \_/\  __//\__, `\
            \ \___,_\ \____/\ \__\\ \_\  \ \_\/\____\ \____\/\____/
             \/__,_ /\/___/  \/__/ \/_/   \/_/\/____/\/____/\/___/ 
EOF

echo -e "\n"
printf "\033[mBytewave's dotfiles install script"
echo -e "\n"

# Source: https://gist.github.com/davejamesmiller/1965569
ask() {
	while true; do
		if [ "${2:-}" = "Y" ]; then
			prompt="Y/n"
			default=Y
		elif [ "${2:-}" = "N" ]; then
			prompt="y/N"
			default=N
		else
			prompt="y/n"
			default=
		fi
		read -p "$1 [$prompt] " REPLY </dev/tty
		if [ -z "$REPLY" ]; then
			REPLY=$default
		fi
		case "$REPLY" in
			Y*|y*) return 0 ;;
			N*|n*) return 1 ;;
		esac
	done
}

dir=$(dirname "$(realpath "$0")")

if ask "Install symlink for .zshrc?" Y; then
	ln -si ${dir}/.zshrc ${HOME}/.zshrc
fi

if ask "Install fzf?" Y; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install \
		--no-update-rc \
		--completion \
		--key-bindings \
		--no-bash \
		--no-fish
fi
