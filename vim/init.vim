source ~/.config/nvim/common.vim

" Hide the tilde characters Vim displays in front of lines after the EOF.
" https://github.com/neovim/neovim/issues/2067
autocmd ColorScheme * call s:hide_tildes()
function! s:hide_tildes()
   hi EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
endfunction
call s:hide_tildes()

" vim: tw=90 sts=-1 sw=3 et
