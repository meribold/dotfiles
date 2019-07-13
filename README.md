**Dotfiles** for [Vim/Neovim](home/vim/), [i3-gaps](home/config/i3/),
[NeoMutt](home/config/neomutt/),
[e](home/config/conky/)[t](home/config/dunst/)[c](home/screenrc).
[p](home/xresources)[p](home/nethackrc).  Bash [functions and aliases](home/bashrc),
[scripts](home/bin/), [keybindings](home/xbindkeysrc), …

<img src="/../media/screenshot.png?raw=true" alt="Screenshot showing an xterm running Bash">

<!--
I don't think a `# dotfiles` caption is needed: just make some interesting points as fast
as possible.

Some dotfiles repos with nice READMEs:
*   <https://github.com/wincent/wincent>
*   <https://github.com/thoughtbot/dotfiles>
*   Maybe some of the ones linked from <https://dotfiles.github.io/>

Generally, these two projects are examples of pretty nice README files, I think:
*   <https://github.com/junegunn/vim-plug>
*   <https://github.com/junegunn/fzf>
-->

<!-- TODO: `## Highlights` section? -->

## Project Structure

The repository is split into three main directories: [`home/`](home/), [`root/`](root/),
and [`misc/`](misc/).
*   `home` contains files that should be linked to from `$HOME` and mirrors that directory
    structure.
*   `root` contains files that should be linked to from *outside* `$HOME`.  Paths reflect
    where symlinks should be created relative to the filesystem root directory.
*   `misc` contains configuration files that don't require linking.

For example, [`home/vim/vimrc`](home/vim/vimrc) would be the target of a link at
`~/.vim/vimrc` and
[`root/usr/local/share/cows/dynamic-duo.cow`](root/usr/local/share/cows/dynamic-duo.cow)
should be linked to from `/usr/local/share/cows/dynamic-duo.cow`.

## Installation

>   You probably shouldn't blindly use these (or anyone's) dotfiles: my setup is personal,
>   opinionated, and sometimes my own information is hard-coded.  Some configuration is
>   not portable and specific to [Arch][] or my ThinkPad.  That being said...

The installation is based on [GNU Make][make] (you most likely have it) and you can
specifically try out the configuration for individual programs without creating any other
links.

*   Clone this repository to `~/dotfiles`.
*   Cherry-pick the configuration for programs you're interested in by giving Make their
    names.  The makefile doesn't replace most conflicting files, they should be removed or
    moved manually first.

    ```bash
    mv ~/.vim ~/.vim.backup
    make vim
    ```

    >   **Don't** install all configuration, some of it is not portable,  **always**
    >   specify targets when running `make`.

    The currently implemented targets are: `vim`, `nvim`, `git`, `bash`, `screen`, `mutt`,
    `conky`, `xterm`, and `gpg`.

Make may consider targets to be up to date because of existing files that conflict with
the links it should create.  The `-B` flag (e.g. `make -B vim`) forces remaking of all
considered targets.  This only results in the removal of conflicting symlinks, but not
regular files.

Use the `-n` flag (e.g. `make -n vim`) to preview the commands Make would execute.

[make]: https://www.gnu.org/software/make/
[arch]: https://archlinux.org

<!-- vim: set tw=90 sts=-1 sw=4 et spell: -->
