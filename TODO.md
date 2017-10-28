### Installation
*   Extend `makefile` to set up symlinks for all files that should have them.
*   Add a phony target for each program for which configuration is included.

### [Vim][]
*   `common.vim` is too big.  Split its contents into multiple files?
*   Add `minimal.vim` vimrc file that's used for `git commit` and
    <kbd>Ctrl</kbd>-<kbd>X</kbd> <kbd>Ctrl</kbd>-<kbd>E</kbd> in Bash?
*   Fix warnings when doing `vim -u NORC`.
*   Use `<C-F>` to toggle the quickfix window?
*   Map `<C-B>` to something more useful.
*   Maybe map `<C-G>` to something more useful.
*   Use fzf for `z=` suggestions.
*   Use a 'foldexpr' for Markdown files.
    *   See <http://vimcasts.org/episodes/writing-a-custom-fold-expression/>.
    *   Use a plugin like
        [vim-markdown-folding](https://github.com/nelstrom/vim-markdown-folding)?
*   Is it possible to soft-wrap at 'textwidth'?
*   Use [par](http://vimcasts.org/episodes/formatting-text-with-par/) for automatic
    paragraph formatting?
*   Try these Vim plugins:
    *   [Powerline](https://github.com/powerline/powerline)
    *   [Projectionist](https://github.com/tpope/vim-projectionist)
    *   [VimShell](https://github.com/Shougo/vimshell.vim)
    *   [Vimwiki](https://github.com/vimwiki/vimwiki)
    *   [ack.vim](https://github.com/mileszs/ack.vim)
    *   [ag.vim](https://github.com/rking/ag.vim)
    *   [deoplete](https://github.com/Shougo/deoplete.nvim)
    *   [investigate.vim](https://github.com/keith/investigate.vim)
    *   [libclang-vim](https://github.com/libclang-vim/libclang-vim)
    *   [neocomplete](https://github.com/Shougo/neocomplete.vim)
    *   [neoterm](https://github.com/kassio/neoterm)
    *   [nvr](https://github.com/mhinz/neovim-remote) (not actually a Vim plugin)
    *   [vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace)
    *   [vim-easygrep](https://github.com/dkprice/vim-easygrep)
    *   [vim-gnupg](https://github.com/jamessan/vim-gnupg)
    *   [vim-journal](https://github.com/junegunn/vim-journal)
    *   [vim-protodef](https://github.com/derekwyatt/vim-protodef)
    *   [vim-quicklink](https://github.com/christoomey/vim-quicklink)
    *   [vim-sexp](https://github.com/guns/vim-sexp)
    *   [vim-signature](https://github.com/kshenoy/vim-signature)
    *   [vim-sort-motion](https://github.com/christoomey/vim-sort-motion)
    *   [vim-swap](https://github.com/machakann/vim-swap)
    *   [vim-textobj-clang](https://github.com/libclang-vim/vim-textobj-clang)
    *   [vim-textobj-line](https://github.com/kana/vim-textobj-line)
    *   [vim-trailing-whitespace](https://github.com/bronson/vim-trailing-whitespace)
    *   [vimproc](https://github.com/Shougo/vimproc.vim)
    *   [vimtex](https://github.com/lervag/vimtex)
    *   [yankring.vim](https://github.com/vim-scripts/YankRing.vim)

[Vim]: /home/vim/

### [Firefox][]
*   **Custom keybinds** (why is this so damn difficult?)
    *   Keybind that sends the current tab to OneTab.
    *   Use [KeySnail](https://github.com/mooz/keysnail)?  It probably will
        [never][keysnail-issue-220] [work][keysnail-issue-222] in Firefox 57 and later.
*   Use [`userChrome.css`][], [`userContent.css`][], and [`user.js`][] more extensively.
*   Add all my custom CSS (both chrome and content) to the repository.

[Firefox]: /home/mozilla/firefox/ctontcrf.default/
[KeySnail]: https://github.com/mooz/keysnail
[keysnail-issue-220]: https://github.com/mooz/keysnail/issues/220
[keysnail-issue-222]: https://github.com/mooz/keysnail/issues/222
[`userChrome.css`]: /home/mozilla/firefox/ctontcrf.default/chrome/userChrome.css
[`userContent.css`]: /home/mozilla/firefox/ctontcrf.default/chrome/userContent.css
[`user.js`]: /home/mozilla/firefox/ctontcrf.default/user.js

#### [Sigaldry][]
*   Convert [Sigaldry][] to use WebExtensions APIs.
*   Use it to keep the set of search engines synchronised between machines and profiles.

[Sigaldry]: /misc/sigaldry

### [Mutt][]
*   Desktop notifications?

[Mutt]: /home/mutt/

### Uncategorized
*   Create a desktop entry file for the [`wifail`](/home/bin/wifail) script.
*   Remove the configuration files for Notion?

<!-- vim: set tw=90 sts=-1 sw=4 et: -->
