" $MYVIMRC
"
" TODO: sort everything in some reasonable way and add folds.  set noshowmode?

" See :h autocmd-define
autocmd!

" comclear

if !has('nvim')
   set nocompatible
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup vim-plug (https://github.com/junegunn/vim-plug).  Plugins are loaded after
" vimrc files (:h initialization).
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-dispatch'

Plug 'tpope/vim-repeat' " Used for surround.vim and commentary.vim.

" Plug 'Shougo/unite.vim'

Plug 'moll/vim-bbye' " :bufdo :Bdelete unloads all buffers.
" Plug 'qpkorr/vim-bufkill'

Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-utils/vim-line'

Plug 'tommcdo/vim-exchange'

" http://reddit.com/r/vim/comments/26mszm/what_is_everyones_favorite_commenting_
Plug 'tpope/vim-commentary'
" Plug 'scrooloose/nerdcommenter'
" Plug 'tomtom/tcomment_vim'

" Plug 'easymotion/vim-easymotion'
" Plug 'goldfeld/vim-seek'
" Plug 'justinmk/vim-sneak'

Plug 'junegunn/vim-easy-align'
" Plug 'godlygeek/tabular'

Plug 'dhruvasagar/vim-table-mode'

" Plug 'plasticboy/vim-markdown' " Depends on tabular?

" I'm using [Grip](https://github.com/joeyespo/grip) to preview Markdown files at the
" moment which actually lets GitHub do the rendering.  The best Vim plugin might be
" suan/vim-instant-markdown.  JamshedVesuna/vim-markdown-preview is somewhat buggy.
" greyblake/vim-preview doesn't seem to do GitHub Flavored Markdown (it uses the redcarpet
" Gem).  There's also the github-markdown-preview Gem and several Chromium extensions that
" render Markdown (http://stackoverflow.com/q/9212340).  TODO:  add a mapping for Grip?

Plug 'itchyny/lightline.vim'
" Plug 'bling/vim-airline'

" Both slow Vim down on my lapotp.
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'Yggdroot/indentLine'

Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'

" Automatically close parens, brackets, braces, quotes, etc.  See
" http://vim.wikia.com/wiki/Automatically_append_closing_characters
Plug 'Raimondi/delimitMate'
" Plug 'jiangmiao/auto-pairs' " Breaks repeat and undo/redo.
" Plug 'Townk/vim-autoclose'  " Inactive.  Try anyway?
" Plug 'kana/vim-smartinput'  " Breaks repeat and undo/redo?
Plug 'tpope/vim-endwise'

Plug 'tpope/vim-unimpaired'

" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-easytags'
" Plug 'szw/vim-tags'
" Plug 'majutsushi/tagbar'

Plug 'vim-scripts/a.vim'
" Plug 'derekwyatt/vim-fswitch'

" Plug 'simnalamburt/vim-mundo'
Plug 'mbbill/undotree'

Plug 'meribold/vim-man'
" Plug 'lambdalisue/vim-manpager'

if has('unix')
   Plug 'beloglazov/vim-online-thesaurus'
endif
Plug 'szw/vim-dict'
Plug 'szw/vim-g'

Plug 'tpope/vim-obsession'
" Plug 'xolox/vim-session'

Plug 'SirVer/ultisnips'

" Plug 'honza/vim-snippets'

" Plug 'Shougo/neocomplete'
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'

" I have vim-youcompleteme-git from the AUR installed.  Upstream is on GitHub at
" Valloric/YouCompleteMe.  I'm not sure I like it, though, and it slows Vim down
" noticeably on my laptop.  It's disabled for now.  [How to turn-off a plugin in Vim
" temporarily?](http://stackoverflow.com/q/601412) [How do you disable a specific plugin
" in Vim?] (http://stackoverflow.com/q/2888970)
if has('unix')
   let g:loaded_youcompleteme = 1
   " Plug 'rdnetto/YCM-Generator'
endif
" Plug 'scrooloose/syntastic'

Plug 'tpope/vim-vinegar'
" Plug 'scrooloose/nerdtree'
"
" Plug 'kien/ctrlp.vim'
" Plug 'szw/vim-ctrlspace'
Plug 'Shougo/unite.vim'

Plug 'vim-utils/vim-husk'
" Plug 'tpope/vim-rsi'

" Plug 'tpope/vim-sleuth'
" Plug 'tpope/vim-speeddating'

" Plug 'terryma/vim-multiple-cursors'

Plug 'junegunn/goyo.vim', { 'on':  'Goyo' }
" Plug 'junegunn/limelight.vim', { 'on':  'Limelight' }
" autocmd! User GoyoEnter Limelight
" autocmd! User GoyoLeave Limelight!

" Stuff to maybe try later.  vimproc?  VimShell?  YankRing.vim?
" Plug 'mileszs/ack.vim'
" Plug 'rking/ag.vim'
" Plug 'tpope/vim-abolish'
" Plug 'vim-sexp'
" Plug 'vim-signature'
" Plug 'vim-better-whitespace'
" Plug 'dkprice/vim-easygrep'
" Plug 'keith/investigate.vim'
" Plug 'kana/vim-textobj-line'
" Plug 'ntpeters/vim-better-whitespace'
" Plug 'bronson/vim-trailing-whitespace'

" Declare Color schemes.
Plug 'meribold/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'jonathanfilip/vim-lucius'
Plug 'itchyny/landscape.vim'
Plug 'vim-scripts/wombat256.vim'
Plug 'vim-scripts/xoria256.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'vim-scripts/Neverness-colour-scheme'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'NLKNguyen/papercolor-theme'
Plug 'sjl/badwolf'
" Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
" Plug 'chriskempson/base16-vim'

call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Let Sneak handle f, F, t and T.
" nmap f <Plug>Sneak_f
" nmap F <Plug>Sneak_F
" xmap f <Plug>Sneak_f
" xmap F <Plug>Sneak_F
" omap f <Plug>Sneak_f
" omap F <Plug>Sneak_F
" nmap t <Plug>Sneak_t
" nmap T <Plug>Sneak_T
" xmap t <Plug>Sneak_t
" xmap T <Plug>Sneak_T
" omap t <Plug>Sneak_t
" omap T <Plug>Sneak_T

" vmap <Enter> <Plug>(EasyAlign)

" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_no_default_key_mappings = 1

" let g:instant_markdown_slow = 1
" let g:instant_markdown_autostart = 0

let g:lightline = {
   \ 'colorscheme': 'default',
\ }
" :h line-continuation, :h dict

" Based on the snippet from :h lightline-problem-13.  Also see [Changing colorscheme on
" the fly](https://github.com/itchyny/lightline.vim/issues/9)
autocmd ColorScheme * call s:lightline_update()
function! s:lightline_update() " Local to this file.
   " TODO: only list color schemes where the name of the lightline color scheme differs
   " from one of the matching Vim color scheme.  Use a directory listing of
   " lightline.vim/autoload/lightline/colorscheme/ for everything else.
   let colos = {
      \ 'molokai': 'molokai',
      \ 'wombat256mod': 'wombat',
      \ 'solarized': 'solarized_dark',
      \ 'landscape': 'landscape',
      \ 'jellybeans': 'jellybeans',
      \ 'Tomorrow-Night': 'Tomorrow_Night',
      \ 'PaperColor': 'PaperColor_dark',
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

" let g:indent_guides_start_level = 2
" let g:indent_guides_guide_size = 1

let g:gitgutter_signs = 0 " The same as 'let gitgutter_signs = 0' here, I guess?

let delimitMate_expand_cr = 1
let delimitMate_jump_expansion = 1
let delimitMate_balance_matchpairs = 1

" Always render man pages at this width, regardless of the size of the window.
" https://github.com/vim-utils/vim-man/issues/14
let g:man_width = 93

" Use local DICT daemon for speed.  These are all databases I have installed.  They are
" listed explicitly to change the order ['*'] would use.
let g:dict_hosts = [
   \ ['localhost', ['gcide', 'eng-deu', 'deu-eng', 'foldoc', 'wn']],
\ ]

" Apparenlty, getting <C-Tab> to work in xterm is [pretty complicated][1] so I should
" probably remap g:UltiSnipsListSnippets instead.  Meta doesn't seem to work in a terminal
" either and remapping escape has its own problems.
" [1]: http://stackoverflow.com/a/2695818
let g:UltiSnipsExpandTrigger = '<C-J>'
" let g:UltiSnipsExpandTrigger = '<Tab>'  " Makes <Tab> laggy.
" let g:UltiSnipsExpandTrigger = '<C-CR>' " Only works in gVim.
" let g:UltiSnipsExpandTrigger = 'q'
let g:UltiSnipsJumpForwardTrigger = '<C-L>'
let g:UltiSnipsJumpBackwardTrigger = '<C-B>'
" These key combinations are more or less available and could also be used:
" i_CTRL-Q, i_CTRL-L, i_CTRL-B, i_CTRL-F, i_CTRL-Z, i_CTRL-M, i_CTRL-J, i_CTRL-_ (this
" seems to be inserted by <C-?>), i_CTRL-\, i_CTRL-G

let g:goyo_height = '100%'
function! GoyoToggle()
   if !exists('#goyo')
      " Set the window width based on the local 'textwidth' instead of g:goyo_width.  Add
      " 1 so Vim doesn't scroll horizontally when the cursor is behind the last character
      " in a full line.
      exe ":Goyo" . (&textwidth + 1)
   else
     Goyo
  endif
endfunction
nnoremap Q :call GoyoToggle()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup Vim for editing in utf-8.  TODO: should this be closer to the top?
" http://stackoverflow.com/q/5477565
" http://superuser.com/q/154491
" http://stackoverflow.com/q/2438021
if has('multi_byte')
   if &termencoding == ''
      let &termencoding = &encoding
   endif
   if !has('nvim')
      " Better default than latin1.  Can't be changed after startup.
      if has('vim_starting') | set encoding=utf-8 | endif
   endif
   setglobal fileencoding=utf-8 " change default file encoding for new files
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make K a well-behaved citizen.  See :h ft-man-plugin, :h find-manpage, :h K, :h v_K,
" :h 'keywordprg'.  TODO: add a vmap for K that works like the built-in mapping.

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

" [Help for word under cursor](http://stackoverflow.com/a/15867465)
" https://github.com/vim-utils/vim-man
" http://vim.wikia.com/wiki/Open_a_window_with_the_man_page_for_the_word_under_the_cursor
" http://vim.wikia.com/wiki/View_man_pages_in_Vim
" http://usevim.com/2012/09/07/vim101-keywordprg/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" [Open help in the current window](http://stackoverflow.com/a/26431632)
" :h 'buftype'
command! -nargs=1 -complete=help H :enew | :set buftype=help | :h <args>

runtime! macros/matchit.vim " Load matchit.vim.  Copied from sensible.vim.

" Don't scan included files for keyword completion.  Taken from sensible.vim.
set complete-=i " Keep?  See https://github.com/tpope/vim-sensible/issues/51.

" Taken from sensible.vim.  See https://github.com/tpope/vim-sensible/issues/13.
set viminfo^=!

set lazyredraw " https://github.com/tpope/vim-sensible/issues/78

syntax enable

" Ubuntu 13.10 disables this by sourcing /usr/share/vim/vim74/debian.vim.
set modeline

set showcmd      " Why does this default to off for Unix ONLY?
set history=1000 " Vim default: 50.
set incsearch    " Search while typing the search command and...
set hlsearch     " hightlight matches.

" Don't automatically yank all visual selections into the "* register.
set clipboard-=autoselect

"set autochdir

" Taken from github.com/tpope/vim-sensible.
if v:version > 703 || v:version == 703 && has('patch541')
   set formatoptions+=j " Delete comment character when joining commented lines.
endif

" Taken from sensible.vim.  Search the 'tags' file in the directory of the current file,
" then the parent directory, then the parent of that, and so on.  The leading './' tells
" Vim to use the directory of the current file rather than Vim's working directory.  The
" trailing semicolon tells it to recursively search parent directories.  See
" :h file-searching.
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display relative line numbers, but the absolute line number in front of the cursor line.
" Useful when preceding vertical motion commands that support it with a count, e.g. d4j.
set number
" set relativenumber " Slows Vim down a lot.  Worth disabling in long files with complex
                   " syntax highlighting sometimes (unimpaired.vim maps this to [or, ]or
                   " and cor).  'cursorline' is similar.
set numberwidth=3  " Minimal number of colums to use for the line number.

" Display relative line numbers (absolute for line cursor is in) in the focused window,
" and absolute in other windows.
" autocmd WinEnter,FocusGained * if &nu == 1 | setl rnu | endif
" autocmd WinLeave,FocusLost * if &nu == 1 | setl nornu | endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Command-line completion (:h cmdline-completion)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*.o  " Don't consider object files when expanding.
set wildmenu         " Use the enhanced command-line completion menu where 'full' is
                     " specified in 'wildmode'.

" When 'wildchar' (Tab) is used first, and more than one match exists, list all
" matches and complete till longest common string.  On consecutive uses (or if
" only one match exists) show the 'wildmenu'.
set wildmode=longest:full,full
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nowrap
set sidescroll=1

set title " Let vim set the terminal title.
" If running inside screen, use those escape sequences to name the window (set the title
" of the VT100 emulated bt screen)
if &term == 'screen' && !has('nvim')
  set t_ts=k
  set t_fs=\
endif " The settings for those termcap codes are taken from vim.wikia.com.
" http://vim.wikia.com/wiki/Automatically_set_screen_title

set scrolloff=2  " Always keep 2 lines above and below the cursor.
set hidden       " Only hide (don't unload) a buffer when abandoned.
set ruler        " Show the ruler.
set laststatus=2 " Always show a status line.

" Required by delimitMate for delimitMate_expand_cr to work.
set backspace=indent,eol,start

" Draw a continuous line to separate vertical splits.
if has('multi_byte') | :set fillchars=vert:│ | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Molokai sets 'background' to light for some reason.  The issue has been
" reported here: https://github.com/tomasr/molokai/issues/22
autocmd ColorScheme * if exists('g:colors_name') &&
   \ (g:colors_name ==# 'molokai' || g:colors_name ==# 'jellybeans') |
   \ noa set bg=dark | endif

" Use a darker background with the lucius color scheme.
let g:lucius_contrast_bg = 'high'

" For C++ and C: don't highlight {}; inside [] and () as errors.
let c_no_curly_error = 1

set background=dark

if !has('gui_running')
   let g:solarized_termcolors = 256
   silent! colorscheme jellybeans
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" These autocommands are to slow on my laptop.  TODO: use a mapping to correct syntax
" highlighting issues when they really occur instead?
" autocmd BufEnter * if &ft != 'help' | syntax sync fromstart | endif
" autocmd BufEnter * if line('$') <= 3000 | syntax sync fromstart | endif
" To check the active synchronization method use ':sy[ntax] sync'.
" http://vim.wikia.com/wiki/Fix_syntax_highlighting

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I used to prefer tabs for indenting and spaces for alignment (like item 4 from
" :h 'tabstop').  That was supposed to allow using different numbers of spaces when
" displaying a tab.
" Because different values will still cause different text widths, I prefer not to use any
" tabs now (item 2 from :h 'tabstop').

set tabstop=8      " A <Tab> counts for 8 spaces.
set softtabstop=-1 " Or does it?
set shiftwidth=3   " Use 3 spaces for each step of (auto)indent.
set shiftround     " Round indent to multiple of 'shiftwidth' when using < and >
                   " commands.
set expandtab      " Use CTRL-V<Tab> to insert a real tab.
set copyindent     " Copy the structure of an existing line's indent when autoindenting
                   " a new line; ensures spaces are used for alignment.
set preserveindent " When changing the indent of the current line, do not replace the
                   " existing indent structure by a series of tabs followed by spaces;
                   " instead preserve as many existing characters as possible, and only
                   " add additional tabs or spaces as required.
set autoindent     " The last two settings only seem to work with this enabled.

" http://vim.wikia.com/wiki/Indenting_source_code#File_type_based_indentation
filetype plugin indent on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight trailing whitespace unless it's in the current line, left of the cursor and
" Vim is in insert mode.  Always highlight tabs that aren't at the start of a line (TODO:
" disable if tabstop is 8?).  I'm using the ColorColumn highlight group instead of
" defining a new one.  TODO: disable for commit messages and netrw?

" This is much faster than using `:syntax match`.  Changing the pattern when entering and
" leaving insert mode also wasn't viable with `:syn clear ColorColumn` and `:syn match`
" since it caused noticeable delay every time.
function! s:OnInsertEnter()
   if exists('w:spaceMatch') | silent! call matchdelete(w:spaceMatch) | endif
   let w:spaceMatch = matchadd('ColorColumn', '\s\+\%#\@<!$', -1)
   " TODO: is there a potentially faster pattern?
endfunction
function! s:OnInsertLeave()
   if exists('w:spaceMatch') | silent! call matchdelete(w:spaceMatch) | endif
   " Use a cheap pattern that doesn't check the cursor position in normal mode.
   let w:spaceMatch = matchadd('ColorColumn', '\s\+$', -1)
endfunction
function! s:OnBufWinEnter()
   " if &modifiable && !&readonly
   if &filetype !=# 'help' && &filetype !=# 'man'
      call s:OnInsertLeave()
      if !exists('w:tabMatch')
         let w:tabMatch = matchadd('ColorColumn', '[^\t]\zs\t\+', -1)
      endif
   else
      if exists('w:spaceMatch')
         silent! call matchdelete(w:spaceMatch)
         unlet w:spaceMatch
      endif
      if exists('w:tabMatch')
         silent! call matchdelete(w:tabMatch)
         unlet w:tabMatch
      endif
   endif
endfunction
function! s:OnWinEnter()
   if !exists('w:spaceMatch') || !exists('w:tabMatch')
      call s:OnBufWinEnter()
   end
endfunction
autocmd InsertEnter * call s:OnInsertEnter()
autocmd InsertLeave * call s:OnInsertLeave()
autocmd BufWinEnter * call s:OnBufWinEnter() " Insufficient.  Try :split without
autocmd WinEnter    * call s:OnWinEnter()    " this.
autocmd FileType    * call s:OnBufWinEnter()

" Don't break when sourcing again.
if exists('w:spaceMatch') || exists('w:tabMatch')
   silent! unlet w:spaceMatch | silent! unlet w:tabMatch
   call clearmatches()
   call s:OnBufWinEnter()
endif

" Use :echo getmatches() to confirm we don't leak matches.  This snippet should never
" create more than two.
" Based on snippets from http://vim.wikia.com/wiki/Highlight_unwanted_spaces.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" No bell, no flash.
if has('patch793')
   set belloff=all
else
   set visualbell
   if !has('nvim')
      set t_vb=
   endif
endif

set maxmem=2000000    " Lots of memory for each buffer.
set maxmemtot=2000000 " Lots of memory for all buffers together.

set undofile " Make undo history persistent.

" set viminfo^=%

" Make a persistent backup whenever writing a file, potentially overwriting an existing
" backup (even if that file isn't the one being backed up; i.e. when different files
" having the same name are edited).
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
" http://stackoverflow.com/questions/1549263/how-can-i-create-a-folder-if-it-doesnt-exist-
" http://vim.wikia.com/wiki/Automatically_create_tmp_or_backup_directories

set shortmess+=I " Don't give the intro message when starting Vim.

" Highlight first column after 'textwidth', except in help files.  TODO: autocmd isn't run
" when the filetype is empty.
set cc=+1
autocmd FileType * if &ft !=# 'help' | setl cc=+1 | else | setl cc= | endif

" Use :W to write the current file with sudo.  Taken from
" http://stackoverflow.com/a/12870763 which fixes some of the problems with
" ':w !sudo tee >/dev/null %'.  I find using a command mode mapping (like 'cmap w!! ...')
" to be annoying.  If the command already exists, redefine it.  See :h E174.
if has('unix')
   com! W sil exe 'w !sudo tee ' . shellescape(@%, 1) . ' >/dev/null'
endif
" http://stackoverflow.com/questions/1005/getting-root-permissions-on-a-file-inside-of-vi
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
" http://unix.stackexchange.com/questions/11004/becoming-root-from-inside-vim
" http://vim.wikia.com/wiki/Su-write

" React to <Esc> immediately (unless it were a proper prefix of a mapping which, of
" course, it isn't).  To be honest, I don't really understand what's going on here.  I
" realize that terminal emulators send key sequences starting with Escape for (at least)
" function keys and arrow keys to the running application.  Vim will wait for more
" characters after receiving the Escape character while it's ambiguous whether those keys
" will make up an escape sequence.  With default settings, Vim will stop waiting after
" 1000 milliseconds (value of 'timeoutlen', used as key code delay when 'ttimeoutlen' is
" negative) of not receiving any additional character and handle the key sequence.  This
" delay seems extremely excessive.  Vim should receive the complete escape sequence
" resulting from function keys etc. nearly at the same instant.  I'm using 0 for
" 'ttimeoutlen' since it doesn't seem to break anything.  I guess around 10 might be more
" conservative.  See :h timeout, :h ttimeoutlen, :h timeoutlen, :h ttimeoutlen, :h esckeys
" http://stackoverflow.com/q/15550100
" http://superuser.com/q/161178
" http://aperiodic.net/phil/archives/Geekery/term-function-keys.html
if !has('gui_running')
   set ttimeoutlen=0
endif

" Taken from sensible.vim before
" github.com/tpope/vim-sensible/commit/e48a40534c132e6dd88176b666a8b1ff7bcf3800 happened.
" Makes Y consistent with C and D.  See :h Y and :h &.
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I'd go with just having the mouse be disabled, however, I don't like the xterm e.g.
" handle middle clicks and send the X PRIMARY selection to Vim which, in normal mode,
" would execute the string as if typed in directly.

set mouse=a " From :help mouse-using: In an xterm, with the currently active mode included
            " in the 'mouse' option, normal mouse clicks are used by Vim, mouse clicks
            " with the shift or ctrl key pressed go to the xterm.

" Since the xterm captures mouse clicks while shift or ctrl is pressed I'm not remapping
" events like <C-LeftMouse>.  Not shure about <M-...> or <A-...>.  Also see
" :help keycodes.

" See :help mouse-using (about using the mouse with a terminal), :help mouse-mode-table to
" see what these buttons normally do and :help <MiddleDrag> for a list of codes for mouse
" clicks.
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
" The default for the <MiddleDrag> and <MiddleRelease> events already is <Nop>.
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

" From :help xterm-copy-paste: Mouse commands requiring the CTRL modifier can be simulated
"                              by typing the 'g' key before using the mouse.
" Some sequences of key presses like <LeftMouse>g<LeftMouse> still perform an action when
" performed quickly   (?_?)
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

" Stop 'hlsearch' highlighting and clear any message displayed on the command-line.  Taken
" from http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
" I wanted to map this to <Esc> but that caused weird behaviour which I tried to fix with
" `autocmd TermResponse * nnoremap <Esc> :noh<Return><Esc>` and
" `nnoremap <esc>^[ <esc>^[` (neither worked).
" http://stackoverflow.com/a/1037182
" http://stackoverflow.com/q/11940801
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" nremapping <CR> breaks the command-line window.  I'm using unimpaired.vim's mappings
" instead now.
" nnorem <CR> o<Esc>

" TODO: map something to <Tab>?

" vim: tw=90 sts=-1 sw=3 et
