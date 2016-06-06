#!/usr/bin/env bash

set -e

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

dir=`pwd`

if ask "Install symlink for .zshrc?" Y; then
	ln -si ${dir}/.zshrc ${HOME}/.zshrc
fi

if ask "Install symlinks for .config/?" Y; then
	if [ ! -d "${HOME}/.config" ] ; then
		if ask "~/.config does not exist. Create?" Y; then
			mkdir ${HOME}/.config/
		fi
	fi

	ln -si ${dir}/.config/* ${HOME}/.config/
fi

if ask "Install symlinks for bin/?" Y; then
	if [ ! -d "${HOME}/bin/" ] ; then
		if ask "~/bin does not exist. Create?" Y; then
			mkdir ${HOME}/bin/
		fi
	fi

	ln -si ${dir}/bin/* ${HOME}/bin/
fi

if ask "Install Neobundle for Neovim?" Y; then
	curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > ${HOME}/neobundle-install.sh
	sh ${HOME}/neobundle-install.sh
	rm ${HOME}/neobundle-install.sh
fi
