#!/usr/bin/env bash

i3-msg 'append_layout ~/.config/i3/scratchpad.json; move scratchpad'
i3-msg 'append_layout ~/.config/i3/workspace-2.json; move workspace 2'

if ! screen -ls; then
   # There's no screen session; create one.
   screen -d -m
   while ! screen -ls; do sleep .1; done
   # Create some new windows inside the screen session.
   screen -X screen && screen -X screen && screen -X 'select' 0
fi

# Disable XON/XOFF flow control before attaching.  I need to do this when the screen
# session was started in detached mode and I'm starting a new xterm that immediately
# attaches.  I don't understand why.
# Note: using `screen -r` for one xterm if we just created a detached session doesn't
# always work because either xterm may attach first (`screen -r` won't attach to a session
# that is already attached somewhere else).  Contrary to what the screen(1) man page says,
# `screen -x` still works when the screen session is detached.
xterm -e 'stty -ixon && exec screen -x' &
xterm -e 'stty -ixon && exec screen -x' &

# vim: tw=90 sts=-1 sw=3 et
