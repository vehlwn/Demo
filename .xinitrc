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
        picom --backend glx --vsync --unredir-if-possible --no-fading-openclose --no-dock-shadow --no-dnd-shadow --fade-in-step 1 --fade-out-step 1 --inactive-opacity 1 &
        exec i3
        ;;
    kde)
        exec startplasma-x11
        ;;
    xfce|xfce4)
        exec startxfce4
        ;;
    *) # No known session, try to run it as command
        exec $1
        ;;
esac

