#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/dotfiles/Xmodmap ]] && xmodmap ~/dotfiles/Xmodmap

# Some fonts from the official repositories are installed here.  TODO: is this still
# required?  Why?
xset +fp /usr/share/fonts/local/

xset -b # Turn off the beep in X.
sh ~/.fehbg & # Set the desktop wallpaper.
[[ $1 != notion ]] && (conky &)

case $1 in
   # The only way I found to start Conky without any issues (that I'm aware of right now)
   # when using Notion (I have 'own_window no' in my .conkyrc):
   notion) [[ -f ~/dotfiles/notion/Xmodmap ]] && xmodmap ~/dotfiles/notion/Xmodmap
           (sleep 0.1; conky) &
           exec notion;;
   # When starting Conky immediately it's not drawn anywhere visible.  Waiting until
   # Notion creates a tiling causes Conky to be drawn "behind" any client windows on the
   # active workspace (and only on that workspace) most times.
   awesome) exec awesome;;
   xmonad) xsetroot -cursor_name left_ptr
           exec xmonad;;
   *) exec twm;;
esac

# vim: tw=90 sts=-1 sw=3 et
