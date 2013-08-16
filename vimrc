"
" .vimrc of Lukas Waymann.
"
" Would most likely not work well on systems much different from mine: the gvim
" package from the [extra] repository of Arch GNU/Linux; in particular the CLI
" version running in an xterm.
" 

set showcmd " Somehow this is off by default on Unix unlike the other default
            " (assuming 'nocompatible') which is 'on'.

set history=40 " 40 lines for each of the five history tables should suffice.

set incsearch " Search while typing the search command.
set hlsearch  " Sometimes this gets annoying.   (=_=)


set relativenumber " Useful when preceding vertical motion commands that support 
                   " it with a count, e.g. d4j


set wildignore+=*.o            " Don't consider object files when expanding.
set wildmenu                   " Use the enhanced command-line completion mode.
set wildmode=longest:full,full " See below.

" Wildmenu mode is used only where 'full' is specified in 'wildmode'. Hence,
" when 'wildchar' is used firstly, and more than one match exists, list all
" matches in wildmenu mode and complete till longest common string. Otherwise,
" if only one match exists or 'wildchar' was used repeatedly, start wildmenu
" mode.


set title " Let vim set the terminal title.

set scrolloff=2 " Always keep 2 lines above and below the cursor.

set hidden " When abandoned a buffer becomes hidden.

set ruler        " Show the ruler.
set laststatus=2 " Every window should always have a status line.


set backspace=indent,eol " Don't allow using nsert mode to delete text other the
                         " the one just added.

" Contrary to what I'd expect from :help 'backspace' the default seems to be
" 'indent,eol,start' here.


" I like to use a tabs for indenting and spaces for alignment (see
" :help 'tabstop' | /4\.). Not using tabs after non-blank characters is
" essential for that style to preserve proper alignement with different settings
" of 'tabstop' and other editors.

set cindent        " 
set tabstop=3      " A <Tab> counts for 3 spaces.
set shiftwidth=3   " Use 3 spaces for each step of (auto)indent.
set copyindent     " Copy the structure of the existing lines indent when
                   " autoindenting a new line; important to ensure spaces are
                   " used for alignment.
" When changing the indent of the current line, do not replace the existing
" indent structure by a series of tabs followed by spaces as required; instead
" preserve as many existing characters as possible, and only add additional tabs
" or spaces as required.
set preserveindent


set visualbell t_vb= " No bell, no flash.

set maxmem=2000000    " Lots of memory for each buffer: 2 GByte!
set maxmemtot=2000000 " Lots of memory for all buffers together: 2 GByte!

set backup                  " Make a persistent backup whenever a writing file
set backupdir=~/.vim/backup " inside ~/.vim/backup/, potentially overwriting an
                            " existing backup (even if that file isn't the one
                            " being backed up; i.e. when different files having
                            " the same name are edited).
set dir=~/.vim/swp//        " ~/.vim/swp/ will not be created automatically.
set undofile                " ...
set undodir=~/.vim/undo     " ...

set showbreak=>\   " Note the escaped trailing space.
set colorcolumn=+1 " Highlight one column after 'textwidth'; normally not used
                   " since 'textwidth' isn't changed from zero in here. Maybe it
                   " would be nice to do this only for files that can be edited.

syntax enable            " 
colorscheme delek
set background=dark      " ...
let c_space_errors = 1   " highlight trailing white space and spaces before a
                         " <Tab> when the c.vim syntax file is used (which is
                         " apperantly included in 'syntax/cpp.vim'.
let c_no_curly_error = 1 " Don't highlight {}; inside [] and () as errors.


	"  -------------->
	"   Key mappings >
	"  ==============>

" Disable the arrow and Page Up/Down keys in all modes except Command-line mode,
" so I'll have to use Normal mode and hopefully the advanced motion commands
" commands will become more natural. See :help keycodes.
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

"   Ratpoison
"  ----------->
"
" Ideally I'd like to just go with the default here: let the mouse be disabled;
" however, the xterm will e.g. handle middle clicks and send the X selection
" PRIMARY to Vim which will execute the string as if typed in directly (which
" gives me nightmares of accidently sending some huge random selection to Vims
" Normal mode).

set mouse=a " From :help mouse-using: In an xterm, with the currently active
            " mode included in the 'mouse' option, normal mouse clicks are used
            " by Vim, mouse clicks with the shift or ctrl key pressed go to the
            " xterm.

" With the following mappings ignoring the mouse should be even easier then when
" actually disabling it.   \o/
" 
" Since the xterm captures mouse clicks while shift or ctrl is pressed events
" like <C-LeftMouse> aren't remapped. Not shure about <M-...> or <A-...>.
" Also see :help keycodes.

" See :help mouse-using, which is about using the mouse with a terminal.
" See :help xterm-copy-paste: Mouse commands requiring the CTRL modifier can be
"                             simulated by typing the 'g' key before using the
"                             mouse.
" See :help mouse-mode-table to see what these buttons normally do.
" See :help <MiddleDrag> to see a list of codes for mouse clicks.
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
" The default for <MiddleDrag> and <MiddleRelease> event is no operation.
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

" Sometimes when executing the next two mappings quickly it still works in help
" files   (?_?)
map  g<LeftMouse>   <Nop>
imap g<LeftMouse>   <Nop>
map  g<RightMouse>  <Nop>
imap g<RightMouse>  <Nop>

" See :h scrolling, in particular :h scroll-mouse-wheel and :h xterm-mouse-wheel
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
" matches. Pressing space turns off highlighting and clears any message already
" displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
