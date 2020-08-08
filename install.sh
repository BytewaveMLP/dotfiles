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

if ask "Install symlink for .vimrc?" Y; then
	ln -si ${dir}/.vimrc ${HOME}/.vimrc
fi

if ask "Install symlink for .xinitrc?" N; then
	ln -si ${dir}/.xinitrc ${HOME}/.xinitrc
fi

if ask "Install symlink for .xprofile?" N; then
	ln -si ${dir}/.xprofile ${HOME}/.xprofile
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

if ask "Install symlink for .gdbinit?" Y; then
	ln -si ${dir}/.gdbinit ${HOME}/.gdbinit
	ln -si ${dir}/.gdb-ignore-errors.py ${HOME}/.gdb-ignore-errors.py
fi

if ask "Install PEDA for gdb?" Y; then
	git clone https://github.com/longld/peda.git ~/peda
fi

if ask "Install Neobundle for Neovim?" N; then
	curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > ${HOME}/neobundle-install.sh
	sh ${HOME}/neobundle-install.sh
	rm ${HOME}/neobundle-install.sh
fi

if ask "Install wallpaper?" N; then
	ln -si ${dir}/.wallpaper.jpg ${HOME}/.wallpaper.jpg
	ln -si ${dir}/.fehbg ${HOME}/.fehbg
fi
