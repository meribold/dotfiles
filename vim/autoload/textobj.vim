" Helper function for defining a text object for the most recently changed or yanked text
" with [vim-textobj-user][1].  See :h '].
" [1]: https://github.com/kana/vim-textobj-user
function! textobj#select_changed()
   return ['v', getpos("'["), getpos("']")]
endfunction

" vim: tw=90 sts=-1 sw=3 et
