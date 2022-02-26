#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar main-bar 2>&1 | tee -a /tmp/polybar-main-bar.log & disown
#polybar second-screen-bar 2>&1 | tee -a /tmp/polybar-second-screen-bar.log & disown

echo "Bars launched..."
