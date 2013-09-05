"
" My .vimrc
"
" Might not work well on systems much different from mine: the gvim package from
" the [extra] repository of Arch GNU/Linux; in particular the CLI version
" running in an xterm.

" See :h autocmd-define
autocmd!
"syntax enable
syntax on

set showcmd        " Why does this default to off for Unix ONLY?
set history=40     " Now with two times the normal history!
set incsearch      " Search while typing the search command and
set hlsearch       " hightlight matches.
set relativenumber " Useful when preceding vertical motion commands that support 
                   " it with a count, e.g. d4j

" Command-line completion (:h cmdline-completion)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*.o  " Don't consider object files when expanding.
set wildmenu         " Use the enhanced command-line completion menu where
                     " "full" is specified in 'wildmode'.

" When 'wildchar' (Tab) is used first, and more than one match exists, list all
" matches and complete till longest common string. On consecutive used (or if
" only one match exists) show the 'wildmenu'.
set wildmode=longest:full,full
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nowrap
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

colorscheme delek
set background=dark
let c_space_errors = 1   " highlight trailing white space and spaces before a
                         " <Tab> when the c.vim syntax file is used (which is
                         " apperantly included in 'syntax/cpp.vim'.
let c_no_curly_error = 1 " Don't highlight {}; inside [] and () as errors.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I like to use tabs for indenting and spaces for alignment (like item 4 from
" :h 'tabstop').

set tabstop=3      " A <Tab> counts for 3 spaces.
set shiftwidth=3   " Use 3 spaces for each step of (auto)indent.
set copyindent     " Copy the structure of an existing lines indent when
                   " autoindenting a new line; ensures spaces are used for
                   " alignment.
set preserveindent " When changing the indent of the current line, do not
                   " replace the existing indent structure by a series of tabs
                   " followed by spaces as required; instead preserve as many
                   " existing characters as possible, and only add additional
                   " tabs or spaces as required.
"set autoindent    " The last two settings only seem to work with this enabled;
"set cindent       " using only 'cindent' makes vim use tabs followed by spaces
                   " everywhere.
filetype plugin indent on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight trailing whitespace and tabs that aren't at the start of a line.
" See http://vim.wikia.com/wiki/Highlight_unwanted_spaces and :h :syn-match.
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=darkred
autocmd Syntax * syn match ExtraWhitespace "\s\+$" containedin=ALL
autocmd Syntax * syn match ExtraWhitespace "[^\t]\zs\t\+" containedin=ALL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set visualbell t_vb=        " No bell, no flash

set maxmem=2000000          " Lots of memory for each buffer.
set maxmemtot=2000000       " Lots of memory for all buffers together.

set backup                  " Make a persistent backup whenever a writing file
set backupdir=~/.vim/backup " inside ~/.vim/backup/, potentially overwriting an
                            " existing backup (even if that file isn't the one
                            " being backed up; i.e. when different files having
                            " the same name are edited).
set dir=~/.vim/swp//        " Directory has to be created manually!
set undofile                " Make undo history persistent.
set undodir=~/.vim/undo     " Directory has to be created manually!

set showbreak=>\            " There's an escaped trailing space here.
set colorcolumn=+1          " Highlight one column after 'textwidth'.

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
