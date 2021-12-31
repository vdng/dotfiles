#!/bin/sh

userresources=$HOME/.Xresources
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# xset r rate 200 20 &
xset s 300 5 &
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- env XSECURELOCK_COMPOSITE_OBSCURER=0 XSECURELOCK_PASSWORD_PROMPT=cursor XSECURELOCK_AUTH_BACKGROUND_COLOR=black XSECURELOCK_AUTH_FOREGROUND_COLOR=#f8f8f2 XSECURELOCK_AUTH_TIMEOUT=5 XSECURELOCK_BLANK_TIMEOUT=5 XSECURELOCK_BLANK_DPMS_STATE=off XSECURELOCK_SHOW_HOSTNAME=0 xsecurelock &
exec awesome
