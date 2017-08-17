#!/bin/bash
# Choose pinentry depending on PINENTRY_USER_DATA.  Requires pinentry-curses and
# pinentry-gtk2 this *only works* with gpg2; see
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=802020

case $PINENTRY_USER_DATA in
   gtk)
      exec /usr/bin/pinentry-gtk-2 "$@" ;;
   *)
      exec /usr/bin/pinentry-curses "$@"
esac

# I copied this script from http://unix.stackexchange.com/q/236746 and linked
# /usr/bin/pinentry to this instead of /usr/bin/pinentry-gtk-2.

# vim: tw=90 sts=-1 sw=3 et
