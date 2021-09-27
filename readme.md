**Dotfiles** for [Vim/Neovim](home/vim/), [i3-gaps](home/config/i3/),
[NeoMutt](home/config/neomutt/),
[e](home/config/conky/)[t](home/config/dunst/)[c](home/screenrc).
[p](home/xresources)[p](home/nethackrc).  Bash [functions and aliases](home/bashrc),
[scripts](home/bin/), [keybindings](home/xbindkeysrc),
[more scripts](misc/xbindkeys-helpers), …

<img src="/../media/screenshot.png?raw=true" alt="Screenshot showing an xterm running Bash" title="Perfection.">

<!--
I don't think a `# dotfiles` caption is needed: just make some interesting points as fast
as possible.

Some dotfiles repos with nice READMEs:
*   <https://github.com/wincent/wincent>
*   <https://github.com/thoughtbot/dotfiles>
*   Maybe some of the ones linked from <https://dotfiles.github.io/>

Generally, these two projects are examples of pretty nice readme files, I think:
*   <https://github.com/junegunn/vim-plug>
*   <https://github.com/junegunn/fzf>
-->

<!-- TODO: `## Highlights` section? -->

There are three main directories: [`home`](home/), [`root`](root/), and [`misc`](misc/).

*   The `home` directory contains files that should be linked to from `$HOME` and mirrors
    its directory structure.
*   The `root` directory contains files that should be linked to from *outside* `$HOME`.
    Paths reflect where symlinks should be created relative to the filesystem root
    directory.
*   The `misc` directory contains files that don't require linking.

For example, [`home/vim/vimrc`](home/vim/vimrc) would be the target of a link at
`~/.vim/vimrc` and
[`root/usr/local/share/cows/dynamic-duo.cow`](root/usr/local/share/cows/dynamic-duo.cow)
should be linked to from `/usr/local/share/cows/dynamic-duo.cow`.

## Installation

Be warned that my setup is personal, opinionated, and sometimes my own information is
hard-coded.  Some configuration is specific to [Arch][], the ThinkPad X220, or otherwise
not portable.  That being said, you can specifically install the configuration for
individual programs without any extraneous changes being made.  Installation uses [GNU
Make][].

*   Clone this repository to `~/dotfiles`.
*   Cherry-pick the configuration for programs you're interested in by giving Make their
    names.  The makefile doesn't replace most conflicting files.  Remove or move them
    manually.  For example:

    ```bash
    mv ~/.vim ~/.vim.backup
    make vim
    ```

    You probably always want to specify targets when running `make` rather than installing
    all configuration.  The currently implemented targets are: `vim`, `nvim`, `git`,
    `bash`, `screen`, `mutt`, `conky`, `xterm`, and `gpg`.

Make may consider targets to be up to date because of existing files that conflict with
the links it should create.  The `-B` flag (e.g. `make -B vim`) forces remaking of all
considered targets.  This only results in the removal of conflicting symlinks, but not
regular files.

Use the `-n` flag (e.g. `make -n vim`) to preview the commands Make would execute.

[GNU Make]: https://www.gnu.org/software/make/
[arch]: https://archlinux.org
