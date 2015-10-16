"
" $MGYVIMRC
"
" This is also sourced when starting the GUI later with :gui.  That makes it
" preferable to put stuff specific to gVim here (instead of into .vimrc behind
" has('gui_running') if statements).

" Don't automatically yank all visual selections into the "* register.
set guioptions-=a

" Remove the menu bar, toolbar, right-hand scrollbar and left-hand scrollbar.
set guioptions-=e go-=m go-=T go-=r go-=L

if has('win32') || has('win64')
   set guifont=Source_Code_Pro:h9,Consolas:h10
   silent! colorscheme solarized
else
   set guifont=Ubuntu\ Mono\ 7,Source\ Code\ Pro\ Medium\ 6
   silent! colorscheme jellybeans
end
let g:solarized_italic = 0

" No bell, no flash.  When the GUI starts, 't_vb' is reset to its default value,
" so we need to set it again here.  See :h visualbell.
set t_vb=

" Don't make the cursor blink!
set guicursor+=a:blinkoff0

" vim: tw=80 sts=3 sw=3 et
