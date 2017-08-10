# Tab completion for the `g` function (defined in ./bashrc).
#
# Link to this file from /usr/share/bash_completion/completions/g.  It will be sourced by
# [bash-completion] when requesting completions for `g`.  The alternative would be to
# source this from one of Bash's startup files, and that's a bit slow ([here's why][1]).

if ! type -t __git_complete; then
   . /usr/share/bash-completion/completions/git
fi

# Taken from http://stackoverflow.com/q/342969#comment22840780_15009611.  This must be
# done after sourcing [git-completion.bash][1] (which is created by the `git` package at
# /usr/share/bash-completion/completions/git on Arch).
__git_complete g __git_main

# [bash-completion]: https://www.archlinux.org/packages/extra/any/bash-completion
# [1]: https://github.com/git/git/blob/master/contrib/completion/git-completion.bash

# vim: tw=90 sts=-1 sw=3 et ft=sh
