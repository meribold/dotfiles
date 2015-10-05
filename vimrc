"
" $MYVIMRC
"
" Might not work well on systems much different from mine: the gvim package from
" the [extra] repository of Arch GNU/Linux; in particular the CLI version
" running in an xterm.

" See :h autocmd-define
autocmd!

" comclear

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup Vundle.  See https://github.com/VundleVim/Vundle.vim for explanations.
" Plugins are loaded after vimrc files (:h initialization).
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Plugin 'tpope/vim-sensible'

Plugin 'tpope/vim-surround'
Plugin 'easymotion/vim-easymotion'

Plugin 'itchyny/lightline.vim'
" Plugin 'bling/vim-airline'

" reddit.com/r/vim/comments/26mszm/what_is_everyones_favorite_commenting_plugin
Plugin 'tpope/vim-commentary'
" Plugin 'scrooloose/nerdcommenter'
" Plugin 'tomtom/tcomment_vim'

" Plugin 'tpope/vim-fugitive'
" Plugin 'airblade/vim-gitgutter'

" Automatically close parens, brackets, braces, quotes, etc.  See
" http://vim.wikia.com/wiki/Automatically_append_closing_characters
Plugin 'Raimondi/delimitMate'
" Plugin 'jiangmiao/auto-pairs' " Breaks repeat and undo/redo.
" Plugin 'Townk/vim-autoclose'  " Inactive.  Try anyway?
" Plugin 'kana/vim-smartinput'  " Breaks repeat and undo/redo?

" Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-easytags'
" Plugin 'szw/vim-tags'

Plugin 'vim-scripts/a.vim'
" Plugin 'derekwyatt/vim-fswitch'

Plugin 'tpope/vim-repeat' " Used for surround.vim and commentary.vim.

Plugin 'sjl/gundo.vim'

Plugin 'meribold/vim-man'
" Plugin 'lambdalisue/vim-manpager'

if has('unix')
   Plugin 'beloglazov/vim-online-thesaurus'
endif
Plugin 'szw/vim-dict'

Plugin 'tpope/vim-obsession'
" Plugin 'xolox/vim-session'

" Stuff to maybe try later.  TODO: Snippets.  VimShell?  YankRing.vim?
" Plugin 'mhinz/vim-startify'
" Plugin 'kien/ctrlp.vim'
" Plugin 'majutsushi/tagbar'
" Plugin 'mileszs/ack.vim'
" Plugin 'rking/ag.vim'
" Plugin 'Shougo/neocomplete.vim'
" Plugin 'tpope/vim-abolish'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'scrooloose/syntastic'
" Plugin 'terryma/vim-multiple-cursors'

" Color schemes.
Plugin 'meribold/molokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'itchyny/landscape.vim'
Plugin 'vim-scripts/wombat256.vim'
Plugin 'vim-scripts/xoria256.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'vim-scripts/Neverness-colour-scheme'
Plugin 'chriskempson/vim-tomorrow-theme'
" Plugin 'chriskempson/base16-vim'

call vundle#end()
filetype plugin indent on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
   \ 'colorscheme': 'default',
\ }
" :h line-continuation, :h dict

" Based on the snippet from :h lightline-problem-13.  Also see [Changing
" colorscheme on the fly](https://github.com/itchyny/lightline.vim/issues/9)
autocmd ColorScheme * call s:lightline_update()
function! s:lightline_update() " Local to this file.
   " TODO: only list color schemes where the name of the lightline color scheme
   " differs from one of the matching Vim color scheme.  Use a directory listing
   " of lightline.vim/autoload/lightline/colorscheme/ for everything else.
   let colos = {
      \ 'molokai': 'molokai',
      \ 'wombat256mod': 'wombat',
      \ 'solarized': 'solarized_dark',
      \ 'landscape': 'landscape',
      \ 'jellybeans': 'jellybeans',
      \ 'Tomorrow-Night': 'Tomorrow_Night',
      \ }
   let newColo = 'default'
   " if exists('g:colors_name') && exists("colos['" . g:colors_name . "']")
   if exists('g:colors_name') && has_key(colos, g:colors_name)
      let newColo = colos[g:colors_name]
   endif
   if g:lightline.colorscheme !=# newColo
      let g:lightline.colorscheme = newColo
      if exists('g:loaded_lightline')
         call lightline#init()
         call lightline#colorscheme()
         call lightline#update()
      endif
   endif
endfunction

let g:gitgutter_signs = 0 " The same as 'let gitgutter_signs = 0' here, I guess?

let delimitMate_expand_cr = 1
let delimitMate_jump_expansion = 1
let delimitMate_balance_matchpairs = 1

" :DictShowDb to see what databases are available on the servers used.
" 'dict.hewgill.com' isn't working at the moment.
let g:dict_hosts = [
   \ ['dict.org', ['gcide', 'fd-eng-deu', 'fd-deu-eng', 'foldoc', 'elements',
      \ 'wn']],
   \ ['dict.hewgill.com', []],
\ ]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make K a well-behaved citizen.  See :h ft-man-plugin, :h find-manpage, :h K,
" :h v_K, :h 'keywordprg'.  TODO: add a vmap for K that works like the built-in
" mapping.

" XXX: will this always be run AFTER 'keywordprg' was changed?
function! s:FixK()
   if &ft ==# 'vim'
      silent! unmap <buffer> K
      setl keywordprg=:help
   elseif &keywordprg ==# ':help'
      setl keywordprg=man
   elseif &keywordprg ==# 'man'
      " I'm using the vim-man plugin.
      nmap <buffer> K <Plug>(Man)
   else
      silent! unmap <buffer> K
   endif
endfunction
autocmd FileType * call s:FixK()
autocmd BufWinEnter * if empty(&ft) | call s:FixK() | endif

" [Help for word under cursor](http://stackoverflow.com/a/15867465/1980378)
" https://github.com/vim-utils/vim-man
" http://vim.wikia.com/wiki/Open_a_window_with_the_man_page_for_the_word_under_the_cursor
" http://vim.wikia.com/wiki/View_man_pages_in_Vim
" http://usevim.com/2012/09/07/vim101-keywordprg/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" [Open help in the current window](http://stackoverflow.com/a/26431632/1980378)
" :h 'buftype'
command! -nargs=1 -complete=help H :enew | :set buftype=help | :h <args>

runtime! macros/matchit.vim " Load matchit.vim.  Copied from sensible.vim.

" Don't scan included files for keyword completion.  Taken from sensible.vim.
set complete-=i " Keep?  See https://github.com/tpope/vim-sensible/issues/51.

" Taken from sensible.vim.  See https://github.com/tpope/vim-sensible/issues/13.
set viminfo^=!

syntax enable

" Ubuntu 13.10 disables this by sourcing /usr/share/vim/vim74/debian.vim.
set modeline

set showcmd      " Why does this default to off for Unix ONLY?
set history=1000 " Vim default: 50.
set incsearch    " Search while typing the search command and...
set hlsearch     " hightlight matches.

"set autochdir

" Taken from github.com/tpope/vim-sensible.
if v:version > 703 || v:version == 703 && has('patch541')
   set formatoptions+=j " Delete comment character when joining commented lines.
endif

" Taken from sensible.vim.  Search the 'tags' file in the directory of the
" current file, then the parent directory, then the parent of that, and so on.
" The leading './' tells Vim to use the directory of the current file rather
" than Vim's working directory.  The trailing semicolon tells it to recursively
" search parent directories.  See :h file-searching.
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup Vim for editing in utf-8.  Taken from stackoverflow.com/questions/
" 5477565/how-to-setup-vim-properly-for-editing-in-utf-8.
if has('multi_byte')
  if &termencoding == ''
    let &termencoding = &encoding
  endif
  set encoding=utf-8           " better default than latin1
  setglobal fileencoding=utf-8 " change default file encoding for new files
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display relative line numbers, but the absolute line number in front of the
" cursor line.  Useful when preceding vertical motion commands that support it
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
                     " 'full' is specified in 'wildmode'.

" When 'wildchar' (Tab) is used first, and more than one match exists, list all
" matches and complete till longest common string.  On consecutive uses (or if
" only one match exists) show the 'wildmenu'.
set wildmode=longest:full,full
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nowrap
set sidescroll=1

set title " Let vim set the terminal title.
" If running inside screen, use those escape sequences to name the window (set
" the title of the VT100 emulated bt screen)
if &term == 'screen'
  set t_ts=k
  set t_fs=\
endif " The settings for those termcap codes are taken from vim.wikia.com [1].

set scrolloff=2  " Always keep 2 lines above and below the cursor.
set hidden       " Only hide (don't unload) a buffer when abandoned.
set ruler        " Show the ruler.
set laststatus=2 " Always show a status line.

" set backspace=indent,eol " In Insert mode, disallow backspacing over the start
"                          " of insert.
set backspace=indent,eol,start " Required by delimitMate for
                               " delimitMate_expand_cr to work.

" Draw a continuous line to separate vertical splits.
if has('multi_byte') | :set fillchars=vert:│ | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Molokai sets 'background' to light for some reason.  The issue has been
" reported here: https://github.com/tomasr/molokai/issues/22
autocmd ColorScheme * if exists('g:colors_name') &&
   \ (g:colors_name ==# 'molokai' || g:colors_name ==# 'jellybeans') |
   \ noa set bg=dark | endif

" Use a darker background with the lucius color scheme.
let g:lucius_contrast_bg = 'high'

let c_space_errors = 1   " highlight trailing white space and spaces before a
                         " <Tab> when the c.vim syntax file is used (which is
                         " apparently included in 'syntax/cpp.vim'.
let c_no_curly_error = 1 " Don't highlight {}; inside [] and () as errors.

set background=dark

if !has('gui_running')
   let g:solarized_termcolors = 256
   silent! colorscheme jellybeans
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" These autocommands are to slow on my laptop.  TODO: use a mapping to correct
" syntax highlighting issues when they really occur instead?
" autocmd BufEnter * if &ft != 'help' | syntax sync fromstart | endif
" autocmd BufEnter * if line('$') <= 3000 | syntax sync fromstart | endif
" To check the active synchronization method use ':sy[ntax] sync'.
" http://vim.wikia.com/wiki/Fix_syntax_highlighting

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I used to prefer tabs for indenting and spaces for alignment (like item 4 from
" :h 'tabstop').  That was supposed to allow using different numbers of spaces
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
" whitespace.  Now I'm just using the ColorColumn highlight group instead.
"highlight ExtraWhitespace ctermbg=darkred guibg=darkred
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=darkred

" Syntax patterns are always interpreted like the 'magic' option is set and like
" the 'l' flag is not included in 'cpoptions' (backslash in a [] range is not
" taken literally, but has its normal meaning).  See :h syn-pattern.

" Highlight trailing whitespace, except when typing at the end of a line.  Taken
" from http://vim.wikia.com/wiki/Highlight_unwanted_spaces.
autocmd Syntax * if &ft !=# 'help' |
   \ syn match ColorColumn "\s\+\%#\@<!$" containedin=ALL | endif

" Highlight tabs that aren't at the start of a line.
autocmd Syntax * if &ft !=# 'help' |
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

" set viminfo^=%

" Make a persistent backup whenever writing a file, potentially overwriting an
" existing backup (even if that file isn't the one being backed up; i.e. when
" different files having the same name are edited).
set backup
set writebackup

if has('unix')
   let s:vimfiles = $HOME . '/.vim'
elseif has('win32') || has('win64')
   " Use $HOME or $USERPROFILE?
   let s:vimfiles = $HOME . '/vimfiles'
endif
if exists('s:vimfiles')
   if !isdirectory(s:vimfiles . '/swp')
      call mkdir(s:vimfiles . '/swp', 'p')
   endif
   if !isdirectory(s:vimfiles . '/undo')
      call mkdir(s:vimfiles . '/undo', 'p')
   endif
   if !isdirectory(s:vimfiles . '/backup')
      call mkdir(s:vimfiles . '/backup', 'p')
   endif
   let &dir = s:vimfiles . '/swp//'
   let &undodir = s:vimfiles . '/undo'
   let &backupdir = s:vimfiles . '/backup'
endif
" http://stackoverflow.com/questions/1549263/how-can-i-create-a-folder-if-it-doe
" http://vim.wikia.com/wiki/Automatically_create_tmp_or_backup_directories

set shortmess+=I " Don't give the intro message when starting Vim.

" Highlight first column after 'textwidth', except in help files.  TODO: autocmd
" isn't run when the filetype is empty.
set cc=+1
autocmd FileType * if &ft !=# 'help' | setl cc=+1 | else | setl cc= | endif

" Use :W to write the current file with sudo.  Taken from
" http://stackoverflow.com/a/12870763/1980378 which fixes some of the problems
" with ':w !sudo tee >/dev/null %'.  I find using a command mode
" mapping (like 'cmap w!! ...') to be annoying.  If the command already exists,
" redefine it.  See :h E174.
if has('unix')
   com! W sil exe 'w !sudo tee ' . shellescape(@%, 1) . ' >/dev/null'
endif
" http://stackoverflow.com/questions/1005/getting-root-permissions-on-a-file-ins
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-tr
" http://unix.stackexchange.com/questions/11004/becoming-root-from-inside-vim
" http://vim.wikia.com/wiki/Su-write

" Taken from sensible.vim before
" github.com/tpope/vim-sensible/commit/e48a40534c132e6dd88176b666a8b1ff7bcf3800
" happened.  Makes Y consistent with C and D.  See :h Y and :h &.
nnoremap Y y$
nnoremap & :&&<CR>
xnoremap & :&&<CR>

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
" remapping  events like <C-LeftMouse>.  Not shure about <M-...> or <A-...>.
" Also see :help keycodes.

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

" Stop 'hlsearch' highlighting and clear any message displayed on the
" command-line.  Taken from
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
" I wanted to map this to <Esc> but that caused weird behaviour which I tried to
" fix with `autocmd TermResponse * nnoremap <Esc> :noh<Return><Esc>` and
" `nnoremap <esc>^[ <esc>^[` (neither worked).
" http://stackoverflow.com/a/1037182/1980378
" http://stackoverflow.com/q/11940801/1980378
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" 1. http://vim.wikia.com/wiki/Automatically_set_screen_title

" vim: tw=80 sts=3 sw=3 et
