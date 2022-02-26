#!/bin/sh

userresources=$HOME/.Xresources
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# xset r rate 200 20 &
exec i3
