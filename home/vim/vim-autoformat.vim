" [vim-autoformat](https://github.com/Chiel92/vim-autoformat) configuration
"
" I also tested [vim-clang-format](https://github.com/rhysd/vim-clang-format), but having
" one plugin that integrates code formatters for many languages seems better.  As far as I
" could see there weren't any advantages to using `clang-format` through vim-clang-format
" instead of vim-autoformat either.
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
" Customize what Python formatters can be used and their order of preference.  Black is
" first.  The default list can by found in vim-autoformat's [defaults.vim][4] file.
let g:formatters_python = ['black', 'yapf', 'autopep8']
" Add `--aggressive` to the [default value of `g:formatdef_autopep8`][4].  TODO: can we
" use Vim's `after-directory` to avoid repeating stuff in [defaults.vim][4]?
let g:formatdef_autopep8 = '"autopep8 --aggressive -" . '
 \ . '(g:DoesRangeEqualBuffer(a:firstline, a:lastline) ? '
 \ . '" --range " . a:firstline . " " . a:lastline : "") . " " . '
 \ . '(&textwidth ? "--max-line-length=" . &textwidth : "")'

" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Operator mappings for vim-autoformat using vim-operator-user.  They don't work when
" using nnoremap and xnoremap.
nmap <Leader>q <Plug>(operator-autoformat)
xmap <Leader>q <Plug>(operator-autoformat)
call operator#user#define_ex_command('autoformat', 'Autoformat')

" Format the entire buffer.
nnoremap <silent> <Leader>Q :Autoformat<CR>

" [1]: https://github.com/Chiel92/vim-autoformat#default-formatprograms
" [2]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html
" [3]: https://clang.llvm.org/docs/ClangFormat.html
" [4]: https://github.com/vim-autoformat/vim-autoformat/blob/555c956db3bdd8ae6f1aa5af1c5fd37eac749e6a/plugin/defaults.vim

" vim: tw=90 sts=-1 sw=3 et
