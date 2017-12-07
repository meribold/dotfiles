" [vim-autoformat](https://github.com/Chiel92/vim-autoformat) configuration
"
" There are some general settings and language-specific settings for C++ and Python in
" here.
"
" vim-autoformat invokes clang-format with arguments matching some of Vim's options (like
" 'textwidth', 'expandtab', and 'shiftwidth'; see the value of g:formatdef_clangformat)
" UNLESS it finds a `.clang-format` or `_clang-format` file.  See [1].
"
" TODO: always prefer using Vim's 'textwidth', 'expandtab' and 'shiftwidth' options?  I
" was hoping this may be possible by passing `-style=file` to clang-format and then using
" the `-style` argument again for some overrides.  Looks like it won't be that easy.

" When no formatprg exists for a filetype, do nothing.  Don't indent, retab, or remove
" trailing whitespace.
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" C++
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Modify some of the [style options][2] vim-autoformat passes to [clang-format][3] when no
" `.clang-format` or `_clang-format` configuration file is found.  The value assigned to
" s:configfile_def is the same as in vim-autoformat's [defaults.vim][4].
let s:configfile_def   = "'clang-format -lines=' . a:firstline . ':' . a:lastline . "
 \ . "' --assume-filename=\"' . expand('%:p') . '\" -style=file'"

" This is slighly modified from [defaults.vim][4].
let s:noconfigfile_def = "'clang-format -lines=' . a:firstline . ':' . a:lastline . "
 \ . "' --assume-filename=\"' . expand('%:p') . '\" -style=\"{"
 \ . "BasedOnStyle: Google, AccessModifierOffset: -1, ' . "
 \ . "(&textwidth ? 'ColumnLimit: ' . &textwidth . ', ' : '') . "
 \ . "(&expandtab ? 'UseTab: Never, IndentWidth: ' . shiftwidth() : 'UseTab: Always') . "
 \ . "'}\"'"

" Copied from [defaults.vim][4] again, except for formatting.
let g:formatdef_clangformat = 'g:ClangFormatConfigFileExists() ? ('
 \ . s:configfile_def . ') : (' . s:noconfigfile_def . ')'

" Python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reverse the order of the preferred formatters for Python compared to what
" [defaults.vim][4] from the plugin would set otherwise.
let g:formatters_python = ['yapf','autopep8']
" Add `--aggressive` to the [default value of `g:formatdef_autopep8`][4].  TODO: can we
" use Vim's `after-directory` to avoid repeating stuff in [defaults.vim][4]?
let g:formatdef_autopep8 = '"autopep8 --aggressive -" . '
 \ . '(g:DoesRangeEqualBuffer(a:firstline, a:lastline) ? '
 \ . '" --range " . a:firstline . " " . a:lastline : "") . " " . '
 \ . '(&textwidth ? "--max-line-length=" . &textwidth : "")'

" [1]: https://github.com/Chiel92/vim-autoformat#default-formatprograms
" [2]: http://clang.llvm.org/docs/ClangFormatStyleOptions.html
" [3]: http://clang.llvm.org/docs/ClangFormat.html
" [4]: https://github.com/Chiel92/vim-autoformat/blob/master/plugin/defaults.vim

" vim: tw=90 sts=-1 sw=3 et
