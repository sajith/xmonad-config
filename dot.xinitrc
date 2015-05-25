# -*- shell-script -*-

if [ -d /etc/X11/xinit/xinitrc.d/ ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# xscreensaver -no-splash &

gnome-screensaver &
xsetroot -cursor_name left_ptr &

eval `ssh-agent`
xterm -e ssh-add

# eval `gnome-keyring-daemon`

exec xmonad

# trayer --monitor 1 --edge right --width 10 --height 48 --expand true --transparent true &
