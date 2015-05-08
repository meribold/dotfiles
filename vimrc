"
" $MYVIMRC
"
" Might not work well on systems much different from mine: the gvim package from
" the [extra] repository of Arch GNU/Linux; in particular the CLI version
" running in an xterm.

" See :h autocmd-define
autocmd!
"syntax enable
syntax on

" Ubuntu 13.10 disables this by sourcing /usr/share/vim/vim74/debian.vim.
set modeline

set showcmd        " Why does this default to off for Unix ONLY?
set history=40     " Now with two times the normal history!
set incsearch      " Search while typing the search command and
set hlsearch       " hightlight matches.
set nojoinspaces   " Don't insert two spaces after a '.', '?' and '!' with a
                   " join command.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup Vim for editing in utf-8. Taken from stackoverflow.com/questions/5477565
" /how-to-setup-vim-properly-for-editing-in-utf-8.
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8              " better default than latin1
  setglobal fileencoding=utf-8    " change default file encoding for new files
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display relative line numbers, but the absolute line number in front of the
" cursor line. Useful when preceding vertical motion commands that support it
" with a count, e.g. d4j.
set number
set relativenumber
set numberwidth=3 " Minimal number of colums to use for the line number.

" Display relative line numbers (absolute for line cursor is in) in the focused
" window, and absolute in other windows.
autocmd WinEnter,FocusGained * if &nu == 1 | setl rnu | endif
autocmd WinLeave,FocusLost * if &nu == 1 | setl nornu | endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Command-line completion (:h cmdline-completion)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*.o  " Don't consider object files when expanding.
set wildmenu         " Use the enhanced command-line completion menu where
                     " "full" is specified in 'wildmode'.

" When 'wildchar' (Tab) is used first, and more than one match exists, list all
" matches and complete till longest common string. On consecutive uses (or if
" only one match exists) show the 'wildmenu'.
set wildmode=longest:full,full
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set nowrap
set sidescroll=1
set listchars+=precedes:<,extends:>

set title " Let vim set the terminal title.
" If running inside screen, use those escape sequences to name the window (set
" the title of the VT100 emulated bt screen)
if &term == "screen"
  set t_ts=k
  set t_fs=\
endif " The settings for those termcap codes are taken from vim.wikia.com [1].

set scrolloff=2  " Always keep 2 lines above and below the cursor.
set hidden       " Only hide (don't unload) a buffer when abandoned.
set ruler        " Show the ruler.
set laststatus=2 " Always show a status line.

set backspace=indent,eol " In Insert mode, disallow backspacing over the start
                         " of insert.

" Draw a continuous line to separate vertical splits.
if has("multi_byte") | :set fillchars=vert:│ | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color schemes I like: molokai, neverness, lucius.
" Web links to get those color schemes:
" molokai at GitHub: https://github.com/tomasr/molokai
" lucius at vim.org: http://www.vim.org/scripts/script.php?script_id=2536

" Molokai sets 'background' to light for some reason. The issue has been
" reported here: https://github.com/tomasr/molokai/issues/22
autocmd ColorScheme * if g:colors_name == 'molokai' | noa set bg=dark | endif

" Use a darker background with the lucius color scheme.
let g:lucius_contrast_bg='high'

let c_space_errors = 1   " highlight trailing white space and spaces before a
                         " <Tab> when the c.vim syntax file is used (which is
                         " apperantly included in 'syntax/cpp.vim'.
let c_no_curly_error = 1 " Don't highlight {}; inside [] and () as errors.

set background=dark

if has("gui_running")
   " If running gVim, remove the menu bar, toolbar, right-hand scrollbar and
   " left-hand scrollbar.
   set guioptions-=e go-=m go-=T go-=r go-=L
   set guifont=Consolas:h10
   let g:solarized_italic=0
   "silent! colorscheme lucius
   "silent! colorscheme wombat
   silent! colorscheme solarized
else
   silent! colorscheme molokai
end
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"autocmd BufEnter * if &ft != 'help' | syntax sync fromstart | endif
autocmd BufEnter * if line('$') <= 3000 | syntax sync fromstart | endif
" To check the active synchronization method use ':sy[ntax] sync'.
" http://vim.wikia.com/wiki/Fix_syntax_highlighting

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I used to prefer tabs for indenting and spaces for alignment (like item 4 from
" :h 'tabstop'). That was supposed to allow using different numbers of spaces
" when displaying a tab.
" Because different values will still cause different text widths, I prefer not
" to use any tabs now (item 2 from :h 'tabstop').

set tabstop=8      " A <Tab> counts for 8 spaces.
set softtabstop=3  " Or does it?
set shiftwidth=3   " Use 3 spaces for each step of (auto)indent.
set shiftround     " Round indent to multiple of 'shiftwidth' when using < and >
                   " commands.
set expandtab      " Use CTRL-V<Tab> to insert a real tab.
set copyindent     " Copy the structure of an existing lines indent when
                   " autoindenting a new line; ensures spaces are used for
                   " alignment.
set preserveindent " When changing the indent of the current line, do not
                   " replace the existing indent structure by a series of tabs
                   " followed by spaces; instead preserve as many existing
                   " characters as possible, and only add additional tabs or
                   " spaces as required.
set autoindent     " The last two settings only seem to work with this enabled.

" http://vim.wikia.com/wiki/Indenting_source_code#File_type_based_indentation
filetype plugin indent on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I used to define an ExtraWhitespace hightlight group instead for unwanted
" whitespace. Now I'm just using the ColorColumn highlight group instead.
"highlight ExtraWhitespace ctermbg=darkred guibg=darkred
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=darkred

" Syntax patterns are always interpreted like the 'magic' option is set and like
" the 'l' flag is not included in 'cpoptions' (backslash in a [] range is not
" taken literally, but has its normal meaning). See :h syn-pattern.

" Highlight trailing whitespace, except when typing at the end of a line. Taken
" from http://vim.wikia.com/wiki/Highlight_unwanted_spaces.
autocmd Syntax * if &ft !~ 'help' |
   \ syn match ColorColumn "\s\+\%#\@<!$" containedin=ALL | endif

" Highlight tabs that aren't at the start of a line.
autocmd Syntax * if &ft !~ 'help' |
   \ syn match ColorColumn "[^\t]\zs\t\+" containedin=ALL | endif

" The help for :syn-containedin seems to expain why some tabs aren't highlighted
" ("Don't forget that keywords never contain another item, thus adding them to
" "containedin" won't work").

" Relevant help subjects: line-continuation, :autocmd, :syn-match, :hi.
" Web links: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" No bell, no flash.
set visualbell t_vb=

set maxmem=2000000    " Lots of memory for each buffer.
set maxmemtot=2000000 " Lots of memory for all buffers together.

set undofile " Make undo history persistent.

if has("win32") || has("win64")
   set nobackup
   set writebackup
   set undodir^=$TEMP
elseif has("unix")
   set dir=~/.vim/swp//        " Directory has to be created manually!
   set undodir=~/.vim/undo     " Directory has to be created manually!
   set backup                  " Make a persistent backup whenever a writing
   set writebackup             " file inside ~/.vim/backup/, potentially
   set backupdir=~/.vim/backup " overwriting an existing backup (even if that
                               " file isn't the one being backed up; i.e. when
                               " different files having the same name are
                               " edited).
end

set showbreak=>\            " There's an escaped trailing space here.

" Highlight first column after 'textwidth', except in help files.
autocmd FileType * if &ft !~ 'help' | setl cc=+1 | else | setl cc= | endif

" Disable the arrow and Page Up/Down keys in all modes except Command-line mode.
" See :help keycodes.
map  <Up>    <Nop>
imap <Up>    <Nop>
map  <Down>  <Nop>
imap <Down>  <Nop>
map  <Left>  <Nop>
imap <Left>  <Nop>
map  <Right> <Nop>
imap <Right> <Nop>

map  <S-Up>    <Nop>
imap <S-Up>    <Nop>
map  <S-Down>  <Nop>
imap <S-Down>  <Nop>
map  <S-Left>  <Nop>
imap <S-Left>  <Nop>
map  <S-Right> <Nop>
imap <S-Right> <Nop>

map  <C-Up>    <Nop>
imap <C-Up>    <Nop>
map  <C-Down>  <Nop>
imap <C-Down>  <Nop>
map  <C-Left>  <Nop>
imap <C-Left>  <Nop>
map  <C-Right> <Nop>
imap <C-Right> <Nop>

map  <kPageUp>   <Nop>
imap <kPageUp>   <Nop>
map  <kPageDown> <Nop>
imap <kPageDown> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I'd go with just having the mouse be disabled, however, I don't like the xterm
" e.g. handle middle clicks and send the X PRIMARY selection to Vim which, in
" normal mode, would execute the string as if typed in directly.

set mouse=a " From :help mouse-using: In an xterm, with the currently active
            " mode included in the 'mouse' option, normal mouse clicks are used
            " by Vim, mouse clicks with the shift or ctrl key pressed go to the
            " xterm.

" Since the xterm captures mouse clicks while shift or ctrl is pressed I'm not
" remapping  events like <C-LeftMouse>. Not shure about <M-...> or <A-...>. Also
" see :help keycodes.

" See :help mouse-using (about using the mouse with a terminal),
" :help mouse-mode-table to see what these buttons normally do and
" :help <MiddleDrag> for a list of codes for mouse clicks.
map  <LeftMouse>    <Nop>
imap <LeftMouse>    <Nop>
map  <LeftDrag>     <Nop>
imap <LeftDrag>     <Nop>
map  <LeftRelease>  <Nop>
imap <LeftRelease>  <Nop>
map  <2-LeftMouse>  <Nop>
imap <2-LeftMouse>  <Nop>
map  <3-LeftMouse>  <Nop>
imap <3-LeftMouse>  <Nop>
map  <4-LeftMouse>  <Nop>
imap <4-LeftMouse>  <Nop>

map  <MiddleMouse>   <Nop>
imap <MiddleMouse>   <Nop>
" The default for <MiddleDrag> and <MiddleRelease> event already is no
" operation.
map  <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map  <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map  <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

map  <RightMouse>   <Nop>
imap <RightMouse>   <Nop>
map  <RightDrag>    <Nop>
imap <RightDrag>    <Nop>
map  <RightRelease> <Nop>
imap <RightRelease> <Nop>
map  <2-RightMouse> <Nop>
imap <2-RightMouse> <Nop>
map  <3-RightMouse> <Nop>
imap <3-RightMouse> <Nop>
map  <4-RightMouse> <Nop>
imap <4-RightMouse> <Nop>

" From :help xterm-copy-paste: Mouse commands requiring the CTRL modifier can be
"                              simulated by typing the 'g' key before using the
"                              mouse.
" Some sequences of key presses like <LeftMouse>g<LeftMouse> still perform an
" action when performed quickly   (?_?)
map  g<LeftMouse>  <Nop>
"imap g<LeftMouse>  <Nop>
map  g<RightMouse> <Nop>
"imap g<RightMouse> <Nop>

" See :h scrolling, :h scroll-mouse-wheel and :h xterm-mouse-wheel.
map  <ScrollWheelUp>      <Nop>
imap <ScrollWheelUp>      <Nop>
map  <S-ScrollWheelUp>    <Nop>
imap <S-ScrollWheelUp>    <Nop>
map  <C-ScrollWheelUp>    <Nop>
imap <C-ScrollWheelUp>    <Nop>
map  <ScrollWheelDown>    <Nop>
imap <ScrollWheelDown>    <Nop>
map  <S-ScrollWheelDown>  <Nop>
imap <S-ScrollWheelDown>  <Nop>
map  <C-ScrollWheelDown>  <Nop>
imap <C-ScrollWheelDown>  <Nop>
map  <ScrollWheelLeft>    <Nop>
imap <ScrollWheelLeft>    <Nop>
map  <S-ScrollWheelLeft>  <Nop>
imap <S-ScrollWheelLeft>  <Nop>
map  <C-ScrollWheelLeft>  <Nop>
imap <C-ScrollWheelLeft>  <Nop>
map  <ScrollWheelRight>   <Nop>
imap <ScrollWheelRight>   <Nop>
map  <S-ScrollWheelRight> <Nop>
imap <S-ScrollWheelRight> <Nop>
map  <C-ScrollWheelRight> <Nop>
imap <C-ScrollWheelRight> <Nop>

" This mapping is taken from vim.wikia.com, tip 14: Highlight all search pattern
" matches. Pressing space turns off highlighting and clears any message shown.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" 1. http://vim.wikia.com/wiki/Automatically_set_screen_title

" vim: tw=80 sw=3 et
