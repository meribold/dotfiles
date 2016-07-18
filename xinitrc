#!/bin/sh

# FIXME: don't use bashisms or change the shebang to explicitly use Bash (are there any
# potential issues with that?).

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

case $1 in
   # The only way I found to start Conky without any issues (that I'm aware of right now)
   # when using Notion (I have 'own_window no' in my .conkyrc):
   notion) [[ -f ~/dotfiles/notion/Xmodmap ]] && xmodmap ~/dotfiles/notion/Xmodmap
           { sleep .1; conky; } &
           exec notion;;
   # When starting Conky immediately it's not drawn anywhere visible.  Waiting until
   # Notion creates a tiling causes Conky to be drawn "behind" any client windows on the
   # active workspace (and only on that workspace) most times.
   awesome) exec awesome;;
   xmonad) xsetroot -cursor_name left_ptr
           exec xmonad;;
   i3) exec i3;;
   *) exec twm;;
esac

# vim: tw=90 sts=-1 sw=3 et
