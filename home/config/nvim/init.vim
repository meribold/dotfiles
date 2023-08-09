" Remove all autocommands for the 'vimrc_init' group.
augroup vimrc_init
   autocmd!
augroup END

source ~/.config/nvim/common.vim

" The default of Neovim 0.6.1 is ".,$XDG_DATA_HOME/nvim/backup//".
set backupdir-=.

if exists('&inccommand')
   set inccommand=nosplit
endif

" Don't show line numbers in terminal windows.  See
" <https://github.com/neovim/neovim/issues/6832> and
" <https://github.com/onivim/oni/issues/962>.
autocmd vimrc_init TermOpen * setlocal nonumber norelativenumber

" See `:h :term`.
autocmd vimrc_common TermOpen * startinsert

function! s:new_mail()
   let l:path = system('mktemp --tmpdir XXXXXXXXXX.eml')
   execute 'sp' l:path
   " See the help for `skeleton`.
   0r ~/.vim/skeleton/skeleton.eml | w | $
endfunction
command! Mail call s:new_mail()

" Do something with Alt.  Maybe just having some normal mode commands in insert mode would
" be cool.
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>
