**Dotfiles** for [Vim and Neovim](home/vim/), [i3-gaps](home/config/i3/),
[NeoMutt](home/config/neomutt/),
[Fontconfig](home/config/fontconfig/),
[e](home/config/conky/)[t](home/config/dunst/)[c](home/screenrc).
[p](home/xresources)[p](home/nethackrc); Bash [functions and aliases](home/bashrc),
[scripts](home/bin/), [keybindings](home/xbindkeysrc),
[more scripts](misc/keybind-scripts), …

<img src="/../media/screenshot.png?raw=true" alt="Screenshot showing an xterm running Bash" title="Perfection.">

## Highlights

See <https://youtu.be/CZxo41Ao_Tc>.

## Structure

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
hard-coded.  Some configuration is specific to [Arch][], my ThinkPad X13 Gen 2, or
otherwise not portable.  That being said, you can specifically install the configuration
for individual programs without any extraneous changes being made.  Installation uses [GNU
Make][].

*   Clone this repository to `~/dotfiles`:

    ```bash
    git clone https://github.com/meribold/dotfiles.git ~/dotfiles
    ```
*   Initialize and clone submodules:

    ```bash
    git submodule update --init --jobs 32
    ```
*   Install the configuration for programs you're interested in by giving Make their
    names.  The makefile generally doesn't replace conflicting files; move or remove them
    manually.  For example:

    ```bash
    mv ~/.vim ~/.vim.backup
    make vim
    ```

    The currently implemented targets are: `vim`, `nvim`, `git`, `bash`, `screen`, `mutt`,
    `conky`, `xterm`, `gpg`, `crontab`, `fortunes`, `irssi`, and `readline`.

Make may consider targets to be up to date because of existing files that conflict with
the links it should create.  The `-B` flag (e.g. `make -B vim`) forces remaking of all
considered targets.  This only results in the removal of conflicting symlinks, but not
regular files.

Use the `-n` flag (e.g. `make -n vim`) to preview the commands Make would execute.

[GNU Make]: https://www.gnu.org/software/make/
[arch]: https://archlinux.org
