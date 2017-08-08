# meribold's dotfiles

Mostly Vim, [Notion][1], [i3-gaps][2], Mutt and Bash stuff.  Some of it is specific to
[Arch][3].

To get tab completion for `g` working, link to
[`root/usr/share/bash-completion/completions/g-completion.bash`](root/usr/share/bash-completion/completions/g-completion.bash)
from `/usr/share/bash-completion/completions/g`:

    ln -s ~/dotfiles/root/usr/share/bash-completion/completions/g-completion.bash /usr/share/bash-completion/completions/g

[1]: http://notion.sf.net/
[2]: https://github.com/Airblader/i3
[3]: https://www.archlinux.org/

<!-- vim: set tw=90 sts=-1 sw=4 et spell: -->
