-# -*- shell-script -*-

# exec gnome-session --session xmonad-gnome-nopanel "$@"

# if [ -d /etc/X11/xinit/xinitrc.d/ ]; then
#    for f in /etc/X11/xinit/xinitrc.d/*; do
#        [ -x "$f" ] && . "$f"
#    done
#    unset f
# fi

xscreensaver &
# gnome-screensaver &

xsetroot -cursor_name left_ptr &

# eval `ssh-agent -k -s`
# eval `ssh-agent -s`
# xterm -e ssh-add

# eval `gnome-keyring-daemon`

# $HOME/org/update.sh

# bash ~/.screenlayout/home.xrandr.sh

exec xmonad
