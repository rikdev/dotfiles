# https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login
if [ -z "${DISPLAY:-}" ] \
	&& [ "$(tty)" = /dev/tty1 ] \
	&& [ -x /usr/bin/startx ]
then
	exec startx
fi
