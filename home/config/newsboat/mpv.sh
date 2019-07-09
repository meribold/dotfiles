#!/usr/bin/env bash

# TODO: consider <https://i3wm.org/docs/userguide.html#no_focus>.

screen -X screen -t "mpv $1" bash -c 'mpv --keep-open -- '\'"$1"\'' || read' &&
# The previous command switched to the newly created window.  Undo that.
screen -X other
