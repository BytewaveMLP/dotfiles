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
	ln -s ${dir}/.zshrc ${HOME}/.zshrc
fi

if ask "Install symlinks for .config/?" Y; then
	ln -s ${dir}/.config/* ${HOME}/.config/
fi

if ask "Install symlinks for bin/?" Y; then
	ln -s ${dir}/bin/* ${HOME}/bin/
fi
