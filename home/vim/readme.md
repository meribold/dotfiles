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

Maybe try some of these plugins:

*   [neoterm](https://github.com/kassio/neoterm)
    *   Neovim-only
    *   Neoterm provides commands for sending code to REPLs using Neovim's built-in
        terminal emulator.
    *   `nnoremap <silent> <Leader>e :TREPLSend<CR>`?
    *   `unlet g:neoterm_automap_keys`?
    *   `Tmap ls`?
*   [nvim-miniyank](https://github.com/bfredl/nvim-miniyank)
    *   Neovim-only
    *   `map p <Plug>(miniyank-autoput)`?
    *   `map P <Plug>(miniyank-autoPut)`?
    *   `map , <Plug>(miniyank-cycle)`?
*   [dwm.vim](https://github.com/spolu/dwm.vim)
    *   I mostly like this but sometimes it tries to do a bit too much automatically.
    *   Maybe only add commands or keybinds for activating a master-and-stack layout and
        for switching the master and/or cycling windows.
*   [gabrielelana/vim-markdown](https://github.com/gabrielelana/vim-markdown)
*   [preservim/vim-markdown](https://github.com/preservim/vim-markdown)
    *   Some of the mappings are pretty nice.
    *   This plugin noticeably slows down opening markdown files.
    *   This plugin optionally depends on tabular.
    *   `let g:vim_markdown_folding_disabled = 1`?
    *   `let g:vim_markdown_math = 1`?
    *   `let g:vim_markdown_frontmatter = 1`?
    *   `let g:vim_markdown_no_default_key_mappings = 1`?
*   [kotlin-vim](https://github.com/udalov/kotlin-vim)
    *   With vim-plug I was able to do this:
        `Plug 'udalov/kotlin-vim', { 'for': ['kotlin'] }`
*   [vim-searchindex](https://github.com/google/vim-searchindex) or
    [vim-indexed-search](https://github.com/henrik/vim-indexed-search)
    *   <https://stackoverflow.com/q/23110833>
    *   <https://vim.wikia.com/wiki/Count_number_of_matches_of_a_pattern>
    *   <https://stackoverflow.com/q/4668623>
*   [loupe](https://github.com/wincent/loupe)
    *   `let g:LoupeClearHighlightMap = 0`?
*   [vim-textobj-pastedtext](https://github.com/saaguero/vim-textobj-pastedtext)
    *   ``nnoremap gp `[v`]``?
*   [Powerline](https://github.com/powerline/powerline),
    [Projectionist](https://github.com/tpope/vim-projectionist),
    [ReplaceWithRegister](https://github.com/vim-scripts/ReplaceWithRegister),
    [VimShell](https://github.com/Shougo/vimshell.vim),
    [Vimwiki](https://github.com/vimwiki/vimwiki),
    [ack.vim](https://github.com/mileszs/ack.vim),
    [ag.vim](https://github.com/rking/ag.vim),
    [deoplete](https://github.com/Shougo/deoplete.nvim),
    [investigate.vim](https://github.com/keith/investigate.vim),
    [libclang-vim](https://github.com/libclang-vim/libclang-vim),
    [neocomplete](https://github.com/Shougo/neocomplete.vim),
    [nvr](https://github.com/mhinz/neovim-remote) (not actually a plugin),
    [python_match.vim](https://github.com/vim-scripts/python_match.vim),
    [splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim),
    [vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace),
    [vim-easyclip](https://github.com/svermeulen/vim-easyclip),
    [vim-easygrep](https://github.com/dkprice/vim-easygrep),
    [vim-journal](https://github.com/junegunn/vim-journal),
    [vim-matchup](https://github.com/andymass/vim-matchup) (doesn't support Python) or
    [vim-most-minimal-folds](https://github.com/vim-utils/vim-most-minimal-folds),
    [vim-move](https://github.com/matze/vim-move),
    [vim-pandoc/vim-pandoc-syntax](https://github.com/vim-pandoc/vim-pandoc-syntax),
    [vim-pandoc/vim-pandoc](https://github.com/vim-pandoc/vim-pandoc),
    [vim-peekaboo](https://github.com/junegunn/vim-peekaboo) (Neovim-only),
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
    [vimtex](https://github.com/lervag/vimtex),
    [yankring.vim](https://github.com/vim-scripts/YankRing.vim)

[`vimrc`]: vimrc
[`init.vim`]: init.vim
[`common.vim`]: common.vim
[1]: https://github.com/rhysd/clever-f.vim "It's *awesome*, by the way."
[2]: https://github.com/meribold/dotfiles/commit/8fa5786f36cc3c65b7155f86596c246efed642e8
    "Try rhysd's clever-f.vim plugin · meribold/dotfiles@8fa5786"
[`fzf`]: https://github.com/junegunn/fzf
[`par`]: http://vimcasts.org/episodes/formatting-text-with-par/
