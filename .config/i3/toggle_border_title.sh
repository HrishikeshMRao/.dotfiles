#!/bin/bash

# Get the current window ID
win_id=$(xdotool getactivewindow)

# Get the current border state of the window
border_state=$(xprop -id $win_id | grep "_NET_WM_STATE_HIDDEN")

if [ -z "$border_state" ]; then
    # If the border is not hidden, hide the border and title
    i3-msg "border pixel 0"
else
    # If the border is hidden, show the border and title
    i3-msg "border normal"
fi
