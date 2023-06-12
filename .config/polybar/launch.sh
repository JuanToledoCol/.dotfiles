#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

# Launch bar
polybar main 2>&1 | tee -a /tmp/polybar1.log & disown 

echo "Bars launched..."
