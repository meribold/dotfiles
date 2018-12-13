" Remove all autocommands for the 'vimrc_init' group.
augroup vimrc_init
   autocmd!
augroup END

source ~/.config/nvim/common.vim

if exists('&inccommand')
   set inccommand=nosplit
endif

" Hide the tilde characters Vim displays in front of lines after the EOF.
" https://github.com/neovim/neovim/issues/2067
autocmd vimrc_init ColorScheme * call s:hide_tildes()
function! s:hide_tildes()
   hi EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
endfunction
call s:hide_tildes()

" Don't show line numbers in terminal windows.  See
" <https://github.com/neovim/neovim/issues/6832> and
" <https://github.com/onivim/oni/issues/962>.
autocmd vimrc_init TermOpen * setlocal nonumber norelativenumber

" Do something with Alt.  Maybe just having some normal mode commands in insert mode would
" be cool.
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>
