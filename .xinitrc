#!/bin/sh

# Merge resources and keymaps

merge_resources() {
	RESOURCES="$1"
	if [ -f "${RESOURCES}" ]; then
		xrdb -merge "${RESOURCES}"
	fi
}

merge_modmap() {
	MODMAP="$1"
	if [ -f "${MODMAP}" ]; then
		xmodmap "${MODMAP}"
	fi
}

merge_resources /etc/X11/xinit/.Xresources
merge_modmap /etc/X11/xinit/.Xmodmap
merge_resources "${HOME}/.Xresources"
merge_modmap "${HOME}/.Xmodmap"

unset -f merge_resources
unset -f merge_modmap

# Run system xinitrc drop-in files

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "${f}" ] && . "${f}"
	done
	unset f
fi

# Set custom settings

xkbcomp "${HOME}/.config/xkb/keymap" "${DISPLAY}"

xset s off
xset dpms 600 600 600

exec i3
