#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

eval $(ssh-agent -s)

setxkbmap latam &
bspwm
xutolock -detectsleep -time 5 -locker 'i3lock -B 10 -k --wrong-text="500" --lock-text="Hack me" --noinput-text="Is Empty" --inside-color=595f74 --ring-color=001315 --keyhl-color=3a3d4c --bshl-color=c35d71 --insidever-color=00aabf --ringver-color=00bdbf --insidewrong-color=a62829 --ringwrong-color=641819' &
