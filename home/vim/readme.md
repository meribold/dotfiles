# Vim Configuration

The main configuration file is [`common.vim`][].  It's used indirectly by both Vim and
Neovim: Vim sources it from [`vimrc`][] and Neovim from [`init.vim`][].

## TODO

*   I think <kbd>;</kbd> (semicolon) and <kbd>,</kbd> (comma) haven't been mapped to
    anything ever since I started using [rhysd's clever-f.vim plugin][1] a [long time
    ago][2].  What a waste.
*   [`common.vim`][] is too big.  Split it into several files.
*   Add `minimal.vim` vimrc file that's used for `git commit` and
    <kbd>Ctrl</kbd>-<kbd>X</kbd> <kbd>Ctrl</kbd>-<kbd>E</kbd> in Bash?
*   Fix warnings when doing `vim -u NORC`.
*   Use `<C-F>` to toggle the quickfix window?
*   Map `<C-B>` to something more useful.
*   Maybe map `<C-G>` to something more useful.
*   Use [`fzf`][] for `z=` suggestions.
*   Use a `'foldexpr'` for Markdown files.
    *   See <http://vimcasts.org/episodes/writing-a-custom-fold-expression/>.
    *   Use a plugin like
        [vim-markdown-folding](https://github.com/nelstrom/vim-markdown-folding)?
*   Is it possible to soft-wrap at `'textwidth'`?  See
    <https://github.com/neovim/neovim/issues/4386>.
*   Use [`par`][] for automatic paragraph formatting?
*   Maybe try some of these Vim plugins:
    [Powerline](https://github.com/powerline/powerline),
    [Projectionist](https://github.com/tpope/vim-projectionist),
    [VimShell](https://github.com/Shougo/vimshell.vim),
    [Vimwiki](https://github.com/vimwiki/vimwiki),
    [ack.vim](https://github.com/mileszs/ack.vim),
    [ag.vim](https://github.com/rking/ag.vim),
    [deoplete](https://github.com/Shougo/deoplete.nvim),
    [investigate.vim](https://github.com/keith/investigate.vim),
    [libclang-vim](https://github.com/libclang-vim/libclang-vim),
    [neocomplete](https://github.com/Shougo/neocomplete.vim),
    [neoterm](https://github.com/kassio/neoterm),
    [nvr](https://github.com/mhinz/neovim-remote) (not actually a plugin),
    [vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace),
    [vim-easygrep](https://github.com/dkprice/vim-easygrep),
    [vim-journal](https://github.com/junegunn/vim-journal),
    [vim-protodef](https://github.com/derekwyatt/vim-protodef),
    [vim-quicklink](https://github.com/christoomey/vim-quicklink),
    [vim-sexp](https://github.com/guns/vim-sexp),
    [vim-signature](https://github.com/kshenoy/vim-signature),
    [vim-sort-motion](https://github.com/christoomey/vim-sort-motion),
    [vim-swap](https://github.com/machakann/vim-swap),
    [vim-textobj-clang](https://github.com/libclang-vim/vim-textobj-clang),
    [vim-textobj-line](https://github.com/kana/vim-textobj-line),
    [vim-trailing-whitespace](https://github.com/bronson/vim-trailing-whitespace),
    [vimproc](https://github.com/Shougo/vimproc.vim),
    [vimtex](https://github.com/lervag/vimtex), and
    [yankring.vim](https://github.com/vim-scripts/YankRing.vim).

[`vimrc`]: vimrc
[`init.vim`]: init.vim
[`common.vim`]: common.vim
[1]: https://github.com/rhysd/clever-f.vim "It's *awesome*, by the way."
[2]: https://github.com/meribold/dotfiles/commit/8fa5786f36cc3c65b7155f86596c246efed642e8
    "Try rhysd's clever-f.vim plugin · meribold/dotfiles@8fa5786"
[`fzf`]: https://github.com/junegunn/fzf
[`par`]: http://vimcasts.org/episodes/formatting-text-with-par/

<!-- vim: set spell: -->
