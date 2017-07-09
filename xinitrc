#!/bin/bash

# *If* inside a screen session, detach and logout ("power detach").  This prevents
# sidestepping whatever mechanism is used to lock the X session and gaining unauthorized
# access to the virtual console from which X is started (either by killing the X server
# with Control+Alt+Backspace or by switching to that virtual console with e.g.
# Control+Alt+F1).  XXX: this does nothing when X isn't started from within a screen
# session.
#
# I'm aware someone with physical access can still compromise security in other ways
# [1][2], but making that a little more difficult is still useful (security isn't binary).
#
[[ $STY ]] && screen -X pow_detach
# [1]: https://superuser.com/q/323144#comment348412_323144
# [2]: https://unix.stackexchange.com/q/40720#comment55641_40720

# TODO: consider sourcing the scripts in /etc/X11/xinit/xinitrc.d/ like
# /etc/X11/xinit/xinitrc does.

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/dotfiles/Xmodmap ]] && xmodmap ~/dotfiles/Xmodmap

# Some fonts from the official repositories are installed here.  TODO: is this still
# required?  Why?
xset +fp /usr/share/fonts/local/

xset -b # Turn off the beep in X.
# Set the desktop wallpaper, wait until feh returns, then start conky.
# { ~/.fehbg; [[ $1 != notion ]] && conky; } &
~/.fehbg &

# Make the multimedia keys do stuff using XBindKeys(1).  Reads ~/.xbindkeysrc.
xbindkeys

# Auto-hide the mouse cursor.  See <https://github.com/Airblader/unclutter-xfixes>.
unclutter --fork

# Start the dunst(1) notification daemon.
dunst &

case $1 in
   # The default is i3: start it when $1 is empty.
   i3 | '') exec i3;;
   # The only way I found to start Conky without any issues (that I'm aware of right now)
   # when using Notion (I have 'own_window no' in my .conkyrc):
   notion) [[ -f ~/dotfiles/notion/Xmodmap ]] && xmodmap ~/dotfiles/notion/Xmodmap
           { sleep .1; conky; } &
           exec notion;;
   # When starting Conky immediately it's not drawn anywhere visible.  Waiting until
   # Notion creates a tiling causes Conky to be drawn "behind" any client windows on the
   # active workspace (and only on that workspace) most times.
   xmonad) xsetroot -cursor_name left_ptr
           exec xmonad;;
   # I didn't realize this was possible.  Not very useful for Firefox but [maybe for
   # graphical games](https://wiki.archlinux.org/index.php/Xinitrc).
   firefox) exec firefox-developer;;
   # Try to start whatever $1 is.
   *) exec "$1";;
esac

# vim: tw=90 sts=-1 sw=3 et
