#!/usr/bin/env bash

# TODO: splitting the screen session and showing the output of mpv in the split isn't that
# well supported by screen... I think tmux could do it better.

screen -X split
screen -X focus
screen -X resize 10
screen -t mpv bash -c 'trap '\''screen -X focus top && screen -X only'\'' EXIT; mpv --keep-open -- '\'"$1"\'
screen -X focus
