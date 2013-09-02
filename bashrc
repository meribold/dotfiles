# ~/.bashrc for my Arch Linux GNU setup.

[[ $- != *i* ]] && return # If not running interactively, don't do anything.

# http://mywiki.wooledge.org/glob
# http://stackoverflow.com/questions/17191622/why-would-i-not-leave-extglob-enab
shopt -s extglob

# # #
# < Stuff concerning Bash's command history >
# #
shopt -s histverify
shopt -u histappend # I fail to see any effect of (un)setting this option. See:
                    # http://superuser.com/questions/136696/bash-history-is-appe

alias ls='ls --color=auto'

export HISTTIMEFORMAT='%F %T  '
export HISTSIZE=5000

# "The  maximum  number  of  lines  contained  in  the  history file" - bash(1).
# As  HISTTIMEFORMAT is used, timestamps are written to separate lines for each
# command and no more than HISTFILESIZE/2 commands are saved.
export HISTFILESIZE=10000
# http://askubuntu.com/questions/15926/how-to-avoid-duplicate-entries-in-bash-hi
export HISTCONTROL=ignoreboth:erasedups

# The pattern used accounts for the space appended when using tab completion.
export HISTIGNORE='@(clear|exit|history|ls|pwd)?( )'


# # #
# < Set Bash's PS1, -2, -3 and -4 prompts >
# #
case "$TERM" in
   xterm-256color|screen*)
      # '\e' should be equivalent to the ANSI escape sequence '\033'. The
      # escaped brackets surrounding these sequences should prevent bash from
      # counting them when determining the cursor position.
      #
      # These are the colors we can use:
      # http://commons.wikimedia.org/wiki/File:Xterm_color_chart.png
      white='\[\e[38;5;231m\]'
      gray='\[\e[38;5;251m\]' # 0xc6 (198) triplet. X11 Gray is 0xbe.
      dark_gray='\[\e[38;5;244m\]'
      black='\[\e[38;5;16m\]'
      #bold_black='\[\e[1;30m\]'
      green='\[\e[38;5;28m\]'
      on_gray='\[\e[48;5;238m\]'
      on_black='\[\e[48;5;0m\]'
      bold='\[\e[1m\]'
      reset='\[\e[m\]'

      PS1=$reset$on_gray'\u'$bold$black'@'$reset$on_gray'\h'
      PS1="$PS1"$dark_gray$on_black' \w '$reset'\$ '$dark_gray
      PS2=$reset$on_gray'>'$reset' '$dark_gray
      PS3=$reset$on_gray'>'$reset' '$dark_gray
      PS3=$reset$on_gray'+'$reset' '$dark_gray

      unset -v white gray dark_gray black bold green on_gray on_black reset

      # Reset the color of the output text. Input text is set to a darker gray
      # by the prompts above. This function is set to be called as part of the
      # DEBUG trap later.
      reset_VT100_character_attributes()
      {
         echo -ne "\e[0m"
      }
      ;;
   *) # Could be 'linux' i.e. a virtual console...
      PS1='\u@\h \w \$ '
      ;;
esac # Web links: https://wiki.archlinux.org/index.php/Color_Bash_Prompt


# # #
# < Rules for setting the terminal title >
# #
case "$TERM" in
   xterm*) # It's an xterm.
      substring='printf "\033]0;%s@%s %s\007" "${USER}" '
      PROMPT_COMMAND="$substring"'"${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
      # http://stackoverflow.com/questions/7316107/bash-continuation-lines

      # Default $PROMPT_COMMAND seems to be: printf "\033]0;%s@%s:%s\007"
      # "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}".

      # Show the currently running command in the terminal title.
      show_command_in_title()
      {
         case "$BASH_COMMAND" in
            *\033]0*)
               # The command is trying to set the title bar as well; this is
               # most likely the execution of $PROMPT_COMMAND. In any case
               # nested escapes confuse the terminal, so don't output them.
               ;;
            *)
               printf "\033]0;%s@%s: %s\007" "${USER}" "${HOSTNAME%%.*}" \
                                             "${BASH_COMMAND}"
               ;;
         esac
      }
      ;;
   screen*) # It's a GNU Screen terminal. I get 'screen.linux' when running
            # screen from inside a virtual console.
      # We could do this (http://aperiodic.net/screen/title_examples) to get
      # information about the running command in the title:
      # PS1='\[\033k\033\\\][\u@\h \W]\$ '

      # ...but this is nicer:
      substring='printf "\033k%s@%s %s\033\\" "${USER}" "${HOSTNAME%%.*}" '
      PROMPT_COMMAND="$substring"'"${PWD/#$HOME/~}"'
      show_command_in_title()
      {
         case "$BASH_COMMAND" in
            *\033]0*)
               ;;
            *)
               printf "\033k%s@%s: %s\033\\" "${USER}" "${HOSTNAME%%.*}" \
                                             "${BASH_COMMAND}"
               ;;
         esac
      }
      ;;
   *)
      # It's something else; what to do?
      ;;
esac # More web links:
# http://mg.pov.lt/blog/bash-prompt.html
# http://www.tldp.org/HOWTO/Xterm-Title-3.html#ss3.1
# http://www.tldp.org/HOWTO/Xterm-Title-4.html#ss4.3

# When exacly does bash receive the the DEBUG signal and execute the command?
# "If a sigspec is DEBUG, the command arg is executed after every simple
# command, for command, case command, select command, every arithmetic for
# command, and before the first command executes in a shell function." - bash(1)
trap '{ reset_VT100_character_attributes;
        show_command_in_title; } 2> /dev/null' DEBUG
# I don't care if these commands weren't defined: redirect to /dev/null.
# Web links:
# http://linux.die.net/Bash-Beginners-Guide/sect_12_02.html.
# http://stackoverflow.com/questions/16636007/can-i-change-the-input-color
# http://stackoverflow.com/questions/9268836/zsh-change-prompt-input-color
# http://stackoverflow.com/questions/3338030/multiple-bash-traps-for-the-same-si
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt#Different_colors_for_text_entry_and_console_output