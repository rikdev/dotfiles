# https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login
# https://wiki.archlinux.org/title/Sway#Automatically_on_TTY_login
if [ -z "${DISPLAY:-}" ] && [ "$(tty)" = /dev/tty1 ]; then
	if [ -x /usr/bin/startx ]; then
		exec startx
	elif [ -x /usr/bin/sway ]; then
		exec sway
	fi
fi
