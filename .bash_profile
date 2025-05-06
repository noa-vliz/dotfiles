# .bash_profile

export LANG=en_US.UTF-8

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc


if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	mmaker -f FluxBox
	exec startx
fi
. "$HOME/.cargo/env"
