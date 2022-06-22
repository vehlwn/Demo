#!/bin/sh

if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

session=${1:-i3}

case $session in
    i3|i3wm)
        xset r rate 300 40
        numlockx on
        gxkb&
        feh --bg-fill ~/Pictures/wallpaper
        dunst&
        exec i3
        ;;
    kde)
        exec startplasma-x11
        ;;
    cin)
        exec cinnamon-session
        ;;
    xfce|xfce4)
        exec startxfce4
        ;;
    *) # No known session, try to run it as command
        exec $1
        ;;
esac

