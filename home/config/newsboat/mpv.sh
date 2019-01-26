#!/usr/bin/env bash

screen -S scratchpad -X screen bash -c 'mpv --keep-open -- '\'"$1"\'' || read' &&
# The previous command switched to the newly created window.  Undo that.
screen -S scratchpad -X other
