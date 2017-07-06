#!/usr/bin/env bash

# Restore the layouts from two files.  Each creates one placeholder window.
i3-msg 'append_layout ~/.config/i3/scratchpad.json; move scratchpad'
i3-msg 'append_layout ~/.config/i3/workspace-2.json; move workspace 2'

# Create two screen sessions: one for the scratchpad and one for a fullscreen terminal.
if ! screen -S scratchpad -ls; then
   # There's no screen session named "scratchpad"; create one.
   screen -S scratchpad -d -m
   while ! screen -S scratchpad -ls; do sleep .1; done
   # Create some new windows inside the screen session.
   screen -S scratchpad -X screen
fi
if ! screen -S fullscreen -ls; then
   screen -d -m -S fullscreen
   while ! screen -S fullscreen -ls; do sleep .1; done
fi

# Start a new xterm and attach to the screen session.  The xterm will be swallowed by a
# placeholder window on the scratchpad workspace.  Do some stuff before attaching:
# *  Disable XON/XOFF flow control with `stty -ixon`.  I need to do this when the screen
#    session was started in detached mode and I'm starting a new xterm that immediately
#    attaches.  Otherwise flow control is enabled.  I don't know why.
# *  Preselect window 1 of the screen session with `-p 1`.
xterm -e 'stty -ixon && exec screen -S scratchpad -x -p 1' &
# Note: using `screen -r` for one xterm if we just created a detached session doesn't
# always work when either xterm may attach first (`screen -r` won't attach to a session
# that is already attached somewhere else).  Contrary to what the screen(1) man page says,
# `screen -x` still works when the screen session is detached.

# Wait a little so the xterm will hopefully be started...
sleep .3

# Set the window height to 29 lines (the height of the xterm; I think it's assumed to be
# 24 otherwise).  Then, send ^L to the input buffer of window 1 (using screen's `stuff`
# command) to clear the terminal screen.  All this does is make sure the prompt is at the
# top and not somewhere in the middle.  See <http://stackoverflow.com/a/25978564>.
screen -S scratchpad -p 1 -X height -w 29
screen -S scratchpad -p 1 -X stuff '^L'

# Select window 0 and repeat the process; it doesn't seem to work when the window isn't
# selected.
screen -S scratchpad -X select 0
screen -S scratchpad -p 0 -X height -w 29
screen -S scratchpad -p 0 -X stuff '^L'

# Start the second xterm and attach to the screen session.  Preselect window 0.  This
# xterm gets placed on workspace 2 and I mainly use it for Vim and Mutt.
xterm -e 'stty -ixon && exec screen -S fullscreen -x -p 0' &

# Wait until the xterm is started again (hopefully)...
sleep .3

# Apparently just sending ^L works fine now.  Maybe something is special about hidden
# scratchpad workspaces.
screen -S fullscreen -p 0 -X stuff '^L'

# TODO: is it possible to set the size of the terminals emulated be screen without
# attaching to the screen session first?

# vim: tw=90 sts=-1 sw=3 et
