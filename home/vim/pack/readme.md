# Some notes

*   I use [dirvish.vim][] and [open-browser.vim][] to replace Netrw.  Unlike Tim Pope's
    [vinegar.vim][], [dirvish.vim][] doesn't depend on Netrw.
*   [repeat.vim][] is an auxiliary plugin that is used by at least surround.vim,
    [commentary.vim][], and unimpaired.vim.
*   The textobj-gitgutter, vim-textobj-comment, and vim-textobj-entire plugins require
    vim-textobj-user.  The first also requires vim-gitgutter.
*   See <https://redd.it/26mszm> for some discussion concerning alternatives to
    [commentary.vim][].
*   Tim Pope's [scriptease.vim][] plugin adds the `g!` operator (evaluate VimL and
    substitute the result).
*   There are two alternatives to [EasyAlign][] I know of: [Tabular][] and [Lion.vim][].
    Tabular is the oldest.  I think it doesn't provide an operator.  Lion.vim is much
    simpler than EasyAlign (its help file has less than 100 lines compared to EasyAlign's
    almost 1000), but EasyAlign tends to automagically do the *right thing* in many common
    cases (like ignoring comments).  Also see [this reddit post](https://redd.it/2lsr8d)
    about EasyAlign.
*   The [vim-slime](https://github.com/jpalardy/vim-slime) plugin enables sending the
    current paragraph to a REPL with `<C-C><C-C>`.
    *   Haskell code is [adapted][1] to the syntax GHCi expects.
    *   I think all of these plugins are similar:
        *   [vim-quickrun](https://github.com/thinca/vim-quickrun)
        *   [slimv](https://github.com/kovisoft/slimv)
        *   [slimux](https://github.com/epeli/slimux)
        *   [neoterm](https://github.com/kassio/neoterm) (for Neovim only)
    *   Also see [this discussion](https://redd.it/4o97kn).
*   I'm using [Grip][] to preview Markdown files.  It lets GitHub do the rendering.  The
    best Vim plugin might be [vim-instant-markdown][].  [vim-markdown-preview][] is
    somewhat buggy.  [vim-preview][] doesn't seem to do GitHub Flavored Markdown (it uses
    the redcarpet Gem).  There's also the [github-markdown-preview][] Gem and several
    Chromium extensions that render Markdown.  See <https://stackoverflow.com/q/9212340>.
*   [vim-sleuth][] automatically adjusts 'shiftwidth' and 'expandtab' heuristically.

# TODO

*   Perhaps color schemes should reside under `opt`.  See `:h repeat.txt`.  Search for
    "Where to put what".
*   Replace [unite-spell-suggest][] with [fzf][] somehow.

[dirvish.vim]: https://github.com/justinmk/vim-dirvish
[open-browser.vim]: https://github.com/tyru/open-browser.vim
[vinegar.vim]: https://github.com/tpope/vim-vinegar
[repeat.vim]: https://github.com/tpope/vim-repeat
[commentary.vim]: https://github.com/tpope/vim-commentary
[scriptease.vim]: https://github.com/tpope/vim-scriptease
[EasyAlign]: https://github.com/junegunn/vim-easy-align
[Tabular]: https://github.com/godlygeek/tabular
[Lion.vim]: https://github.com/tommcdo/vim-lion
[1]: https://github.com/jpalardy/vim-slime/tree/master/ftplugin/haskell
[Grip]: https://github.com/joeyespo/grip
[vim-instant-markdown]: https://github.com/suan/vim-instant-markdown
[vim-markdown-preview]: https://github.com/JamshedVesuna/vim-markdown-preview
[vim-preview]: https://github.com/greyblake/vim-preview
[github-markdown-preview]: https://github.com/dmarcotte/github-markdown-preview
[vim-sleuth]: https://github.com/tpope/vim-sleuth
[unite-spell-suggest]: https://github.com/kopischke/unite-spell-suggest
[fzf]: https://github.com/junegunn/fzf
