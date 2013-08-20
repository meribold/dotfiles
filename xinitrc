[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/.Xmodmap ]] && /usr/bin/xmodmap $HOME/.Xmodmap

# Some fonts from the official repositories are installed here. TODO: is this
# still required? Why?
xset +fp /usr/share/fonts/local/

xset -b     # Turn off the beep in X.
sh ~/.fehbg # Set the desktop wallpaper.
conky -dq

case $1 in
  notion) exec notion;;
  awesome) exec awesome;;
  *) exec twm;;
esac

