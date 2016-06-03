# ~/.bashrc for Arch Linux and Ubuntu

# This file is sourced by login shells and interactive non-login shells.  On at least
# Debian and Arch Linux, Bash is compiled with the `-DSYS_BASHRC="/etc/bash.bashrc"`
# option, which makes it source /etc/bash.bashrc first for interactive non-login shells.
# See https://wiki.archlinux.org/index.php/Bash#Configuration_files and
# http://unix.stackexchange.com/q/187369.

# FIXME: ShellCheck warnings.

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Clear PROMPT_COMMAND.  It's set from /etc/bash.bashrc on Arch Linux.
unset PROMPT_COMMAND

# Load fzf(1) key bindings (https://github.com/junegunn/fzf).
[[ -f /usr/share/fzf/key-bindings.bash ]] && . /usr/share/fzf/key-bindings.bash

# Source z.sh (https://github.com/rupa/z); z(1) jumps to frecent directories and it's
# faster than autojump (I haven't tried fasd, which is similar too).  This appends a
# command to PROMPT_COMMAND that's terminated with a semicolon.
if [[ -f /usr/lib/z.sh ]]; then
   . /usr/lib/z.sh
   unalias z # I use j for z.
fi

# http://mywiki.wooledge.org/glob
# http://stackoverflow.com/q/17191622
shopt -s extglob

# Perform history expansion on the current line and insert a space, with space.  See
# bash(1).  For example, typing !!<Space> will replace the !! with the previous command.
bind Space:magic-space

# Disable XON/XOFF flow control.  See stty(1),
# http://unix.stackexchange.com/q/12107/115980 and
# https://en.wikipedia.org/wiki/Software_flow_control.
stty -ixon

# Send ASCII DEL (0x7F) for the backspace key instead of ASCII BS (0x08).  This is some
# sort of de-facto standard and xterm doesn't follow it by default on my system.  Update:
# I'm fixing it from Xresources instead of here now.
# stty erase 

# Horrible hacks are happening here.
if [[ "$TERM" == screen* ]]; then
   # Fix Control+H in xterms that are immediately (on startup) attached to a screen
   # session started in detached mode.  Control+H erases all characters before the cursor
   # instead of just one without this.
   stty kill 
   # Fix Control+H in those xterms again.  GNU Readline's key bindings are different in
   # them for some reason: in particular, Control+H (C-h in Emacs-style notation) is bound
   # to `unix-line-discard` instead of `backward-delete-char`.  That means it kills all
   # text from the cursor to the beginning of the line instead of acting like backspace.
   # I swear it was working without this before...  maybe some upgrade broke stuff again.
   # See `help bind`, readline(3) and `info readline`.
   bind '\C-h: backward-delete-char'
fi

# Aliases and functions for interactive use {{{1
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Aliases for ls.
alias ls='ls --color=auto'
alias  l='ls -F'
alias la='ls -FA'
alias ll='ls -lh'

# List subdirectories (http://stackoverflow.com/a/171938).
alias lsd='ls -d */'

# Jump into the most 'frecent' directory matching all arguments.  Normally like z(1) but
# when used without arguments, use fzf to select a directory.  Adapted from
# https://github.com/junegunn/fzf/wiki/Examples#z.
j() {
   [[ $# -gt 0 ]] && _z "$*" && return
   cd "$(_z 2>&1 | fzf --tac --no-sort | sed 's/^[0-9.]* *//')"
}

# Select a line from snippets.bash with fzf and paste the selection to stdin with
# Control+I (xterm is configured to send ÿ when Control+I is pressed, so it can be
# distinguished from Tab).  I just copied and adapted the code used in
# /usr/share/fzf/key-bindings.bash to set up the Control+R readline key binding.
bind '"ÿ": " \C-e\C-u$(fzf < ~/dotfiles/snippets.bash)\e\C-e\e^\er"'

# Select a song from the current MPD playlist with fzf and start playing it.  If only one
# matches "$*", bypass fzf.  Based on https://github.com/junegunn/fzf/wiki/Examples#mpd
# but this version shows the next song to be played first.
p() {
   local playlist
   local length
   local current_song
   local new_song
   playlist=$(mpc -f '%position% %artist% - %title%' playlist) || return 1
   # If the current MPD playlist is empty, return.
   [[ $playlist ]] || return 1
   length=$(wc -l <<< "$playlist") || return 1
   current_song=$(mpc -f "%position%" current) || return 1
   current_song=${current_song:-0}
   new_song=$(awk -v l="$length" '{$1 = ($1 - 1 + l - '"$current_song"') % l; print}' \
                 <<< "$playlist" \
            | sort -k1 -V \
            | awk -v l="$length" '{$1 = ($1 + '"$current_song"') % l + 1":"; print}' \
            | fzf --query="$*" --select-1 --exit-0 \
            | sed -n 's/^\([0-9]\+\):.*/\1/p')
   [[ $? -ne 0 ]] && return 1
   [[ -n $new_song ]] && mpc -q play "$new_song"
}

# Aliases for humans.
alias df='df -h'
alias free='free -h'

alias info='info --vi-keys'

alias v='$VISUAL'

alias gds='git diff --staged'

alias starwars='telnet towel.blinkenlights.nl'

alias vims='vim --servername vim' # "VIM" is the only server name that makes
alias vimr='vim --remote'         # "vim --remote" etc. work without having to use
alias vimrt='vim --remote-tab'    # "--servername".

# `alert` alias for use with long-running commands.  For example, `sleep 10; alert` will
# send a desktop notification after `sleep 10` is done (if a notification daemon like
# "Notify OSD" or "dunst" is running).  Adapted from Ubuntu's .bashrc.  See
# notify-send(1).
alias alert='notify-send -i "$([[ $? == 0 ]] && echo terminal || echo error)" '\
'"$(history | tail -1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Get the system's public IP address.  Taken from http://unix.stackexchange.com/a/81699.
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'

# Shortcut for `git.`  Runs `git status -s` when called with no arguments, otherwise acts
# like `git`.  From https://github.com/thoughtbot/dotfiles/blob/master/zsh/functions/g.
g() {
   if [[ $# -gt 0 ]]; then
      git "$@"
   else
      git status -s
   fi
}

d() { dict "$@" |& less; }

# Translate a word from English to German and vice versa.  I don't know how to invoke
# `dict` specifying more than one database to search (exception: searching all available
# databases is no problem), so this functions runs `dict` twice: once for "eng-deu" and
# once for "deu-eng".  Then, the output is processed to make it look like a normal
# invocation of `dict` in all cases.
t() {
   local output status other_output other_status
   output=$(dict -d eng-deu -- "$1" 2>&1)
   status=$?
   other_output=$(dict -d deu-eng -- "$1" 2>&1)
   other_status=$?
   # See http://mywiki.wooledge.org/BashFAQ/002.
   if [[ $status -eq 0 && $other_status -eq 0 ]]; then
      # Both commands succeeded (should happen for `t kindergarten`, for example).
      # Merge the "definition found" lines.
      declare -i definition_count # Using `declare` also renders variables local.
      definition_count=${output%% *}
      definition_count+=${other_output%% *}
      echo "$definition_count definitions ${output#* * }"
      # See http://wiki.bash-hackers.org/syntax/pe.
      # Remove the top line.
      echo "$other_output" | tail -n +2
   elif [[ $status -eq 0 ]]; then
      # Only the first lookup succeeded.
      echo "$output"
   elif [[ $other_status -eq 0 ]]; then
      # Only the second lookup succeeded.
      echo "$other_output"
   else
      # SNAFU.
      if [[ $other_output = *'perhaps you mean'* ]]; then
         echo "$other_output" | head -n 1
      else
         echo "$output" | head -n 1
      fi
      echo "$output" | tail -n +2
      echo "$other_output" | tail -n +2
   fi
   # Tests passed: `t curious`, `t du`, `t la`, `t treee`, `t lassso`, `t kindergarten`,
   # `t haus`, `t nun`.
}

# Idea from https://www.reddit.com/r/bash/comments/4cqbnh.
weather() {
   # http://superuser.com/q/173209/curl-how-to-suppress-strange-output-when-redirecting
   curl --silent --fail --show-error "wttr.in/${1:-}" | head -n -3
}

# Print the remaining amount of energy stored in the battery identified by `BAT1`.  This
# is what works on my ThinkPad X121e and is probably not portable to other laptops without
# changes.
bat() {
   now=$(</sys/class/power_supply/BAT1/energy_now)
   full=$(</sys/class/power_supply/BAT1/energy_full)
   # http://mywiki.wooledge.org/ArithmeticExpression
   percent=$((100 * now / full))
   now=$(bc <<< "scale=1; $now / 1000000")
   full=$(bc <<< "scale=1; $full / 1000000")
   echo "$now Wh / $full Wh (${percent}%)"
}

# Select a file with fzf and open it with xdg-open.  If only one file matches "$1", bypass
# fzf (`--select-1`).  Exit fzf immediately if there's no match (`--exit-0).  Adapted from
# the snippets at https://github.com/junegunn/fzf/wiki/Examples.  xdg-open is ran in the
# background and all its file descriptors are redirected do /dev/null.  See
# https://felixmilea.com/2014/12/running-bash-commands-background-properly,
# http://superuser.com/a/178592 and https://gist.github.com/dualbus/9275406.
o() {
   local file
   file=$(fzf --query="$1" --select-1 --exit-0)
   [[ -n $file ]] && { xdg-open "$file" &>/dev/null <&1 & disown; }
}

# Stuff concerning Bash's command history {{{1
shopt -s histverify

# Append new history lines from each Bash session to $HISTFILE when the shell exits,
# rather than overwriting the file with the history list.  When histappend is unset,
# running several instances of Bash at the same time will result in the ``new'' history
# lines of all but the last instance that exits to be lost.  Having histappend unset also
# may pose an additional risk of losing (part of) the history if something goes wrong
# while overwriting the file.  See bash(1) and http://unix.stackexchange.com/a/6509.
shopt -s histappend

HISTTIMEFORMAT='%F %T  '
HISTSIZE=10000

# "The maximum number of lines contained in the history file" - bash(1).  As
# $HISTTIMEFORMAT is used, timestamps are written to separate lines for each command and
# no more than ($HISTFILESIZE / 2) commands are saved.
HISTFILESIZE=20000
# http://askubuntu.com/q/15926
HISTCONTROL=ignoreboth:erasedups

# The pattern used accounts for the space appended when using tab completion.
HISTIGNORE='@(clear|exit|history|ls|pwd|bg|fg|g)?( )'

# Set Bash's PS1 and PS2 prompts {{{1
case "$TERM" in
   xterm-256color|xterm-termite|screen*)
      # '\e' should be equivalent to the ANSI escape sequence '\033'.  The escaped
      # brackets surrounding these sequences should prevent Bash from counting them when
      # determining the cursor position.
      # white='\[\e[38;5;231m\]'
      # X11 Gray is 0xbe.
      # gray='\[\e[38;5;251m\]' # 0xc6 (198) triplet.
      dark_gray='\[\e[38;5;246m\]' # 0x94 triplet.
      black='\[\e[38;5;16m\]'
      #bold_black='\[\e[1;30m\]'
      #green='\[\e[38;5;28m\]'
      # on_light_gray='\[\e[48;5;251m\]' # 0x94 triplet.
      on_gray='\[\e[48;5;236m\]' # 0x30 triplet.
      #on_black='\[\e[48;5;0m\]'
      bold='\[\e[1m\]'
      reset='\[\e[m\]'
      # Colors: http://commons.wikimedia.org/wiki/File:Xterm_color_chart.png
      #         http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

      PS1="$reset$dark_gray"'\n\342\224\214'
      PS1+="$reset$on_gray"'[\u'"$bold${black}@$reset$on_gray"'\h]'
      PS1+="$reset$dark_gray"' \w\n'
      PS1+='\342\224\224\342\224\200 '"$reset$bold"'\$ '"$reset$dark_gray"
      # If the last command's output didn't end with a newline, add one.  I don't know how
      # it works, but it does.  From http://serverfault.com/q/97503.
      PS1='$(printf "%$(($(tput cols)-1))s\r")'"$PS1"
      PS2="$reset${dark_gray}\342\224\224\342\224\200 $reset${bold}> $reset$dark_gray"

      unset -v white gray dark_gray black bold on_light_gray on_gray on_black reset

      # Reset the color of the output text.  Input text is set to a darker gray by the
      # prompts above.  This function is set to be called as part of the DEBUG trap later.
      reset_VT100_character_attributes()
      {
         echo -ne "\e[0m"
      }
      ;;
   *) # Could be 'linux', i.e. a virtual console...
      PS1='\n\342\224\214[\u@\h] \w\n\342\224\224\342\224\200 \$ '
      PS1='$(printf "%$(($(tput cols)-1))s\r")'"$PS1"
      ;;
esac # Web links: https://wiki.archlinux.org/index.php/Color_Bash_Prompt

# Rules for setting the terminal title {{{1
case "$TERM" in
   xterm*) # It's an xterm.
      # Try to remove a semicolon from the end of PROMPT_COMMAND.  Then append '; ' unless
      # PROMPT_COMMAND is unset or empty.  See http://wiki.bash-hackers.org/syntax/pe.
      PROMPT_COMMAND="${PROMPT_COMMAND%;}"
      PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }"
      # We can safely append new commands to PROMPT_COMMAND now.
      PROMPT_COMMAND+='printf "\033]0;%s@%s %s\007" "$USER" "${HOSTNAME%%.*}"'
      PROMPT_COMMAND+=' "${PWD/#$HOME/\~}"'
      # http://stackoverflow.com/q/7316107

      # On Arch Linux and for most terminals, /etc/bash.bashrc sets PROMPT_COMMAND to:
      #    printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"
      # I'm unsetting PROMPT_COMMAND at the top of this file, but we could just keep it
      # (TODO?)

      # TODO: explain this better.  Isn't this redundant?
      show_command_in_title() # Show the currently running command in the terminal title.
      {
         case "$BASH_COMMAND" in
            *033]0*)
               # The command is trying to set the title bar as well; this is most likely
               # the execution of $PROMPT_COMMAND.  In any case nested escapes confuse the
               # terminal, so don't output them.
               ;;
            *)
               printf "\033]0;%s@%s: %s\007" "$USER" "${HOSTNAME%%.*}" "$BASH_COMMAND"
               ;;
         esac
      }
      ;;

   screen*) # It's a GNU Screen terminal.  I get 'screen.linux' when running screen from
            # inside a virtual console.
      # We could do this (http://aperiodic.net/screen/title_examples) to get information
      # about the running command in the title:
      #    PS1='\[\033k\033\\\][\u@\h \W]\$ '
      # ...but this is nicer:
      PROMPT_COMMAND="${PROMPT_COMMAND%;}"
      PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }"
      PROMPT_COMMAND+='printf "\033k%s@%s %s\033\\" "$USER" "${HOSTNAME%%.*}"'
      PROMPT_COMMAND+=' "${PWD/#$HOME/\~}"'
      show_command_in_title()
      {
         case "$BASH_COMMAND" in
            *033]0*)
               ;;
            *)
               printf "\033k%s@%s: %s\033\\" "$USER" "${HOSTNAME%%.*}" "$BASH_COMMAND"
               ;;
         esac
      }
      ;;

   *)
      # It's something else.
      ;;
esac # More web links:
# http://mg.pov.lt/blog/bash-prompt.html
# http://www.tldp.org/HOWTO/Xterm-Title-3.html#ss3.1
# http://www.tldp.org/HOWTO/Xterm-Title-4.html#ss4.3

# When exacly does bash receive the the DEBUG signal and execute the command?
# "If a sigspec is DEBUG, the command arg is executed after every simple command, for
# command, case command, select command, every arithmetic for command, and before the
# first command executes in a shell function." - bash(1)
trap '{ reset_VT100_character_attributes; show_command_in_title; } 2>/dev/null' DEBUG
# I don't care if these commands weren't defined: redirect to /dev/null.  This should be
# the last command in ~/.bashrc.  If there are more, the terminal title will be changed
# for each one, increasing the startup time.
# Web links:
# http://linux.die.net/Bash-Beginners-Guide/sect_12_02.html.
# http://stackoverflow.com/q/16636007
# http://stackoverflow.com/q/9268836
# http://stackoverflow.com/q/3338030
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt#Different_colors_for_text_entry_and_console_output

# vim: tw=90 sts=-1 sw=3 et fdm=marker
