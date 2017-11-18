# Vim Configuration

The main configuration file is [`common.vim`][].  It's used indirectly by both Vim and
Neovim: Vim sources it from [`vimrc`][] and Neovim from [`init.vim`][].

## TODO

*   I think <kbd>;</kbd> (semicolon) and <kbd>,</kbd> (comma) haven't been mapped to
    anything ever since I started using [rhysd's clever-f.vim plugin][1] a [long time
    ago][2].  What a waste.
*   [`common.vim`][] is too big.  Split it into several files.

[`vimrc`]: vimrc
[`init.vim`]: init.vim
[`common.vim`]: common.vim
[1]: https://github.com/rhysd/clever-f.vim "It's *awesome*, by the way."
[2]: https://github.com/meribold/dotfiles/commit/8fa5786f36cc3c65b7155f86596c246efed642e8
    "Try rhysd's clever-f.vim plugin · meribold/dotfiles@8fa5786"

<!-- vim: set tw=90 sts=-1 sw=4 et spell: -->
