" Use [vim-textobj-user][1] to define a text object for the most recently changed or
" yanked text.  For example, text that was just pasted can be indented with `=gp`.
" [1]: https://github.com/kana/vim-textobj-user
call textobj#user#plugin('', {
\  'text': {
\     'select-function': 'textobj#select_changed',
\     'select': 'gp',
\  },
\ })

" vim: tw=90 sts=-1 sw=3 et
