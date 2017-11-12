#!/usr/bin/env bash

# TODO: splitting the screen session and showing the output of mpv in the split isn't that
# well supported by screen... I think tmux could do it better.

screen -X split
screen -X focus
screen -X resize 10
# TODO: it's probably possible and preferable to reduce the number of options passed to
# mpv here, and instead configure it with a dedicated file.
screen bash -c 'trap '\''screen -X focus top && screen -X only'\'' EXIT; mpv '\''--ytdl-format=best[height<=768]'\'' --keep-open -- '\'"$1"\'
screen -X focus
