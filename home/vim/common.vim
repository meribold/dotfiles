" Shared initialization commands.  Sourced from both init.vim (Neovim) and vimrc (Vim).

" Vim comes with some bundled plugins in various subdirectories of $VIMRUNTIME.  Those in
" plugin/ are enabled by default but there are some more in pack/dist/opt/ and macros/
" that are not.  TODO: take a look if any should be dis- or enabled.

" Remove all autocommands for the 'vimrc_common' group.  I was using the default unnamed
" group for all autocommands in my vimrc files before and just ran `autocmd!` without
" setting the group (using the default group implicitly).  This was causing issues as some
" of the bundled VimL files also use the default group so sourcing this file again after
" startup would kill their autocommands as well (e.g., syntax highlighting did stop being
" enabled automatically in new buffers).  I think the default autocommand group should be
" reserved for users, but alas...
augroup vimrc_common
   autocmd!
augroup END

" Conditionally loaded plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins are loaded after vimrc files (:h initialization).

" This is needed because we call `operator#user#define_ex_command` later (by sourcing
" `vim-autoformat.vim`).  TODO: find a better way.
packadd! vim-operator-user

if has('unix')
   packadd! vim-dict
endif

" Automated management of tag files.  I chose [Gutentags][1] semi-randomly: it has some
" cool features like incremental tags generation but [there][2] [are][3] [many][4]
" [similar][5] [plugins][6], none of which I tried.
" [1]: https://github.com/ludovicchabant/vim-gutentags
" [2]: https://github.com/basilgor/vim-autotags
" [3]: https://github.com/soramugi/auto-ctags.vim
" [4]: https://github.com/craigemery/vim-autotag
" [5]: https://github.com/szw/vim-tags
" [6]: https://github.com/xolox/vim-easytags
if executable('ctags')
   packadd! vim-gutentags
end

" TODO: Investigate whether pastery.vim still considerably slows down starting Vim.  See
" <https://github.com/skorokithakis/pastery.vim/issues/2>.
if has('unix')
   packadd! pastery.vim
endif

if executable('fzf')
   packadd! fzf.vim
endif

" Snippet engine using Python.  Doesn't define any snippets by itself; they are in
" honza/vim-snippets (but I'm only using my own snippets at the moment).
if has('python') || has('python3') " TODO: is this what we should check?
   packadd! ultisnips
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Basic settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stuff taken from sensible.vim

" Most (all?) of this is probably redundant for Neovim.  TODO: move it into vim/vimrc?
" There probably also are more settings scattered around this file that belong in this
" section.

" TODO: plugins are loaded after personal vimrc files; should this command therefore be at
" the very end of this file or in a different file inside an after/ subdirectory?
runtime! macros/matchit.vim " Load matchit.vim.

" Don't scan included files for keyword completion.
set complete-=i " Keep?  See <https://github.com/tpope/vim-sensible/issues/51>.

" See <https://github.com/tpope/vim-sensible/issues/13>.
set viminfo^=!

if v:version > 703 || v:version == 703 && has('patch541')
   set formatoptions+=j " Delete comment character when joining commented lines.
endif

" Search the 'tags' file in the directory of the current file,
" then the parent directory, then the parent of that, and so on.  The leading './' tells
" Vim to use the directory of the current file rather than Vim's working directory.  The
" trailing semicolon tells it to recursively search parent directories.  See
" :h file-searching.
if has('path_extra')
   setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

" Stuff that used to be part of sensible.vim

" Enabling 'lazyredraw' causes slight visual glitches sometimes.  It [made][1] [it's][2]
" [way][3] into sensible.vim, but [was removed][4] again.
" [1]: https://github.com/tpope/vim-sensible/issues/78
" [2]: https://github.com/tpope/vim-sensible/pull/89
" [3]: https://github.com/tpope/vim-sensible/commit/2fb074e
" [4]: https://github.com/tpope/vim-sensible/commit/9e91be7
set nolazyredraw " This currently is the default.

" Make Y consistent with C and D.  See `:h Y` and `:h &`.  Additionally, change & to
" *exactly* repeat the last substitute (it drops any flags by default).  These three lines
" were removed from sensible.vim by [e48a405][].
nnoremap Y y$
nnoremap & :&&<CR>
xnoremap & :&&<CR>
" [e48a405]: https://github.com/tpope/vim-sensible/commit/e48a40534c132e6dd88176b666a8b1ff

" Use <Space> as <Leader> and <Bslash> as <LocalLeader>.
let mapleader = ' '
let maplocalleader = '\'
" Make sure <Space> doesn't do anything by itself.
map <Space> <Nop>

" Use Unix-style line endings for new buffers and files on Windows too.
if has('win32')
   set fileformat=unix
   set fileformats=unix,dos
endif

" Don't silently fix my shitty files.  I don't want noisy diffs.
set nofixeol

" Ubuntu 13.10 disables this by sourcing /usr/share/vim/vim74/debian.vim.
set modeline

set clipboard^=unnamedplus

" Make ^X^K work without having spell checking enabled (without `:set spell`).
set dictionary+=spell

set noshowcmd

" Hide the tilde characters Vim displays in front of lines after the EOF.
set fillchars=eob:\ 

" The default is 4000.  The help file of <https://github.com/airblade/vim-gitgutter>
" recommends 100.
set updatetime=400

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display relative line numbers, but the absolute line number in front of the cursor line.
" Useful when preceding vertical motion commands that support it with a count, e.g. d4j.
set number
set relativenumber " Slows Vim down a lot.  Worth disabling in long files with complex
                   " syntax highlighting sometimes (unimpaired.vim maps this to [or, ]or
                   " and cor).  'cursorline' is similar.
set numberwidth=4  " Minimal number of columns to use for line numbers.  The value
                   " accounts for one space that is always added between the line numbers
                   " and the text.  4 means that the width has to be increased in buffers
                   " with 1000 or more lines.  Bigger values can look nicer when
                   " 'colorcolumn' is used, because the highlighted columns of horizontal
                   " splits are more likely to line up.

" Display relative line numbers (absolute for line cursor is in) in the focused window,
" and absolute in other windows.
" autocmd vimrc_common WinEnter,FocusGained * if &nu == 1 | setl rnu | endif
" autocmd vimrc_common WinLeave,FocusLost * if &nu == 1 | setl nornu | endif

set norelativenumber " It's just to slow on my laptop...
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Command-line completion (:h cmdline-completion)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu " Use the enhanced command-line completion menu where 'full' is specified in
             " 'wildmode'.
" When 'wildchar' (Tab) is used first, and more than one match exists, list all matches
" and complete till longest common string.  On consecutive uses (or if only one match
" exists) show the 'wildmenu'.
set wildmode=longest:full,full

" Patterns to ignore when expanding wildcards:
set wildignore+=.hg/,.git/,.svn/                     " version control stuff
set wildignore+=*.aux,*.out,*.toc                    " LaTeX auxiliary files
set wildignore+=_minted-*/                           " minted cache directory
set wildignore+=*.o                                  " object files
set wildignore+=*.bmp,*.gif,*.jpeg,*.jpg,*.pdf,*.png " more binary files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nowrap
set sidescroll=1 " Scroll horizontally smoothly (one column at a time) instead of jumping.

set hidden        " Only hide (don't unload) a buffer when abandoned.
set laststatus=2  " Always show a status line.
set showtabline=0 " Never display tab labels.

" This only makes a difference when there's a popup window (used by fzf), I think.  If it
" weren't for `/usr/share/vim/vimfiles/archlinux.vim`, 'ruler' would also be off by
" default in Vim (although using `defaults.vim` would change that).  Neovim's default for
" 'ruler' is to turn it on.
set noruler

" Required by delimitMate for delimitMate_expand_cr to work.  TODO: move this to vimrc:
" this already is the Neovim default.
set backspace=indent,eol,start

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

" Tweak what automatic indenting does when 'cindent' is enabled.  See `indent.txt` and
" 'cindent' and 'cinoptions'.  Maybe <https://vim.fandom.com/wiki/Indenting_source_code>
" as well.  Note that 'cindent' is automatically enabled for C and C++ files (e.g. from
" `/usr/share/nvim/runtime/indent/c.vim` or `cpp.vim`, try `:verb set cindent?`).  TODO:
" Python (see <https://orchistro.tistory.com/236>).
set cinoptions=g.501s,h.499s,N-s,(0,Ws

set linebreak             " Wrap lines at characters in 'breakat', not at the last
if exists('&breakindent') " character that fits on the screen.
   set breakindent        " Continue lines at their indentation level when wrapping.
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set undofile " Make undo history persistent.

" TODO: what was the idea with this?
" set viminfo^=%

set shortmess+=I " Don't give the intro message when starting Vim.

" Make a persistent backup whenever writing a file, potentially overwriting an existing
" backup (even if that file isn't the one being backed up; i.e., when different files
" having the same name are edited).
set backup
set writebackup

" Use the 'en_us' instead of the 'en' word list as the default for spell checking.  This
" helps with consistently using one spelling when (e.g.) American and British English
" differ (color, colour; gray, grey, ...).  I'm using the American instead of the British
" (or any other) word list for no particular reason; the point is just to have Vim help
" with spelling stuff in one way consistently (one thing I prefer about American English
" is that spellings are usually shorter than their British counterparts, though).  Note
" that the highlighting for misspellings that would be correct according to another
" regional variety of English are highlighted differently than other spelling errors.  See
" `:h spell`.
set spelllang=en_us

set winminwidth=0 winminheight=0
set winwidth=97

set splitright

" This requires patch 9.1.0572 (https://github.com/vim/vim/commit/5247b0b92e191a046b0341).
set tabclose=left

" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw, vim-dirvish, open-browser.vim
" Disable netrw by [pretending it's already loaded][1].  I use [dirvish.vim][2], which
" [doesn't depend on netrw][3], and [open-browser.vim][4] (to replace netrw's gx mapping)
" instead.
" [1]: https://stackoverflow.com/a/21687112
" [2]: https://github.com/justinmk/vim-dirvish
" [3]: https://reddit.com/comments/4l00pj//d3j7a8j
" [4]: https://github.com/tyru/open-browser.vim
let loaded_netrwPlugin = 1

" Use gx to open the URL the cursor is on.  If the cursor doesn't appear to be on a URL,
" do a web search for the word it's on instead.
nmap gx <Plug>(openbrowser-smart-search)
" Ditto for visual mode.
xmap gx <Plug>(openbrowser-smart-search)

" Search with DuckDuckGo by default.
let g:openbrowser_default_search = 'duckduckgo'

" EditorConfig plugin
" Don't automagically fix my shitty files: don't fix newlines, don't fix trailing
" whitespace, and don't fix a file's last line lacking a newline.  Prevent noisy diffs.
" These issues should be fixed in bulk with a single commit rather than piecemeal.
let g:EditorConfig_disable_rules = [
   \ 'end_of_line', 'trim_trailing_whitespace', 'insert_final_newline'
\ ]

" textobj-word-column.vim
" Skip the plugin's default mappings: they conflict with those of vim-textobj-comment.
let g:skip_default_textobj_word_column_mappings = 1
xnoremap <silent> ab :<C-U>call TextObjWordBasedColumn('aw')<CR>
xnoremap <silent> aB :<C-U>call TextObjWordBasedColumn('aW')<CR>
xnoremap <silent> ib :<C-U>call TextObjWordBasedColumn('iw')<CR>
xnoremap <silent> iB :<C-U>call TextObjWordBasedColumn('iW')<CR>
onoremap <silent> ab :call TextObjWordBasedColumn('aw')<CR>
onoremap <silent> aB :call TextObjWordBasedColumn('aW')<CR>
onoremap <silent> ib :call TextObjWordBasedColumn('iw')<CR>
onoremap <silent> iB :call TextObjWordBasedColumn('iW')<CR>

" Source separate configuration files.  See `:h filename-modifiers`, `:h fnamemodify` and
" <http://ryrych.pl/protips/2016-04-23-splitting-vim-config-into-modules-protip/>.  I used
" to just use the `:source` command with an absolute path (~/.vim/...); that broke when I
" symlinked to my Vim configuration from `~/vimfiles` on Windows.
let s:vimrc_path = fnamemodify($MYVIMRC, ':h') .. '/'
exe 'so ' .. s:vimrc_path .. 'vim-autoformat.vim'

" neomake
let g:neomake_echo_current_error = 0
let g:neomake_place_signs = 0

" commentary.vim
autocmd vimrc_common FileType markdown setlocal commentstring=<!--%s-->

" vim-instant-markdown
" let g:instant_markdown_slow = 1
" let g:instant_markdown_autostart = 0

" lightline.vim
let g:lightline = {
   \ 'component': {
   \    'lines': '%L',
   \    'modified': '%{&modified?"+":""}',
   \ },
   \ 'inactive': {
   \    'left': [['filename']],
   \    'right': [[], ['winnr']],
   \ },
   \ 'active': {
   \    'left': [['mode', 'paste'], ['filename', 'modified']],
   \    'right': [[], ['lines']],
   \ },
   \ 'component_visible_condition': {
   \    'modified': '&modified',
   \ },
   \ 'colorscheme': 'jellyjam',
\ }

" Based on the snippet from :h lightline-problem-13.  Also see issue #9 on Github:
" ["Changing colorscheme on the fly"](https://github.com/itchyny/lightline.vim/issues/9).
autocmd vimrc_common ColorScheme * call s:lightline_update()
function! s:lightline_update() " Local to this file.
   " FIXME: only list color schemes where the name of the lightline color scheme differs
   " from the one of the matching Vim color scheme.  Use a directory listing of
   " lightline.vim/autoload/lightline/colorscheme/ for everything else.
   let colos = {
      \ 'molokai': 'molokai',
      \ 'wombat256mod': 'wombat',
      \ 'solarized': 'solarized_dark',
      \ 'landscape': 'landscape',
      \ 'jellybeans': 'jellybeans',
      \ 'jellyjam': 'jellyjam',
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

" vim-indent-guides
" let g:indent_guides_start_level = 2
" let g:indent_guides_guide_size = 1

" vim-gitgutter
let g:gitgutter_enabled = 0  " Turn vim-gitgutter off by default.
let g:gitgutter_realtime = 0 " Don't trigger sign updates when not typing.
let g:gitgutter_eager = 0    " Update signs less often; mostly just when writing a buffer.

" delimitMate
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
let delimitMate_balance_matchpairs = 1

" pastery.vim
let g:pastery_open_in_browser = 1
runtime pastery-api-key.vim

" vim-rooter
let g:rooter_silent_chdir = 1

" vim-dict
" Use local DICT daemon for speed.  These are all databases I have installed.  They are
" listed explicitly to change the order ['*'] would use.
let g:dict_hosts = [['localhost', ['gcide', 'eng-deu', 'deu-eng', 'foldoc', 'wn']]]

" vim-gutentags
" See `:helpgrep gutentags_cache_dir` and
" <https://wiki.archlinux.org/title/XDG_Base_Directory>.
let g:gutentags_cache_dir = '~/.cache/gutentags'

" ultisnips
" Apparently, getting <C-Tab> to work in xterm is [pretty complicated][1] so I should
" probably remap g:UltiSnipsListSnippets instead.  Meta doesn't seem to work in a terminal
" either and remapping escape has its own problems.
" [1]: https://stackoverflow.com/a/2695818
let g:UltiSnipsExpandTrigger = '<C-J>'
" let g:UltiSnipsExpandTrigger = '<Tab>'  " Makes <Tab> laggy.
" let g:UltiSnipsExpandTrigger = '<C-CR>' " Only works in gVim.
" let g:UltiSnipsExpandTrigger = 'q'
let g:UltiSnipsJumpForwardTrigger = '<C-L>'
let g:UltiSnipsJumpBackwardTrigger = '<C-B>'
" These key combinations are more or less available and could also be used:
" i_CTRL-Q, i_CTRL-L, i_CTRL-B, i_CTRL-F, i_CTRL-Z, i_CTRL-M, i_CTRL-J, i_CTRL-_ (this
" seems to be inserted by <C-?>), i_CTRL-\, i_CTRL-G

" unite.vim
" Replace the built-in z= mapping with a less obtrusive interface based on unite.vim.
nnoremap z= :Unite spell_suggest<CR>

" Not-so-basic settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Draw a continuous line to separate vertical splits.
if has('multi_byte') | :set fillchars+=vert:│ | endif

" [Open help in the current window](https://stackoverflow.com/a/26431632)
" :h 'buftype'
command! -nargs=1 -complete=help H :enew | :set buftype=help | :h <args>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Molokai sets 'background' to light for some reason.  The issue has been reported here:
" <https://github.com/tomasr/molokai/issues/22>.
autocmd vimrc_common ColorScheme * if exists('g:colors_name') &&
   \ (g:colors_name ==# 'molokai' || g:colors_name ==# 'jellybeans') |
   \ noa set bg=dark | endif

" Use a darker background with the lucius color scheme.
let g:lucius_contrast_bg = 'high'

" For C++ and C: don't highlight {}; inside [] and () as errors.
let c_no_curly_error = 1

set background=dark

if !has('gui_running')
   let g:solarized_termcolors = 256
   silent! colorscheme jellyjam
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" These autocommands are to slow on my laptop.  TODO: use a mapping to correct syntax
" highlighting issues when they really occur instead?
" autocmd vimrc_common BufEnter * if &ft != 'help' | syntax sync fromstart | endif
" autocmd vimrc_common BufEnter * if line('$') <= 3000 | syntax sync fromstart | endif
" To check the active synchronization method use ':sy[ntax] sync'.
" https://vim.wikia.com/wiki/Fix_syntax_highlighting

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
   if &filetype !=# 'help' && &filetype !=# 'man' && &filetype !=# 'unite'
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
autocmd vimrc_common InsertEnter * call s:OnInsertEnter()
autocmd vimrc_common InsertLeave * call s:OnInsertLeave()
autocmd vimrc_common BufWinEnter * call s:OnBufWinEnter() " Insufficient.  Try :split
autocmd vimrc_common WinEnter    * call s:OnWinEnter()    " without this.
autocmd vimrc_common FileType    * call s:OnBufWinEnter()

" Don't break when sourcing again.
if exists('w:spaceMatch') || exists('w:tabMatch')
   silent! unlet w:spaceMatch | silent! unlet w:tabMatch
   call clearmatches()
   call s:OnBufWinEnter()
endif

" Use :echo getmatches() to confirm we don't leak matches.  This snippet should never
" create more than two.
" Based on snippets from <https://vim.wikia.com/wiki/Highlight_unwanted_spaces>.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use the 'colorcolumn' option to highlight the first column after 'textwidth' in the
" focused window, but only if the buffer is 'modifiable' and 'noreadonly'.
autocmd vimrc_common WinEnter * if &ma && !&ro | setl cc=+1 | endif
autocmd vimrc_common WinLeave * setl cc=
" WinEnter isn't triggered when loading a new buffer into the current window.
autocmd vimrc_common BufWinEnter * if &ma && !&ro | setl cc=+1 | endif

" Alias for the :SudoWrite command from [eunuch.vim](https://github.com/tpope/vim-eunuch):
" use :W to write the current file with sudo.
if has('unix')
   command! -bar W :SudoWrite
endif

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
" https://stackoverflow.com/q/15550100
" https://superuser.com/q/161178
" http://aperiodic.net/phil/archives/Geekery/term-function-keys.html
if !has('gui_running')
   set ttimeoutlen=0
endif

" If we have `rg`, use it to `:grep`.  If we don't have `rg` but have Ag, use Ag.  TODO:
" There are lots of related plugins [1][2][3][4].  Do they provide worthwhile improvements
" compared to just setting 'grepprg'?
if executable('rg')
   set grepprg=rg\ --vimgrep
   set grepformat=%f:%l:%c:%m
elseif executable('ag')
   " I copied this from ag(1); search for `--vimgrep`.  Also see [5], [this comment][6] by
   " Romain Lafourcade, and these [two][7] [posts][8].  TODO: are the :Grep and :LGrep
   " commands from Romain's comment cool?
   set grepprg=ag\ --vimgrep
   set grepformat=%f:%l:%c:%m
endif
" [1]: https://github.com/rking/ag.vim
" [2]: https://github.com/mileszs/ack.vim
" [3]: https://github.com/mhinz/vim-grepper
" [4]: https://github.com/Chun-Yang/vim-action-ag
" [5]: https://www.vi-improved.org/recommendations/
" [6]: https://reddit.com/comments/4gjbqn//d2iatu9
" [7]: https://codeinthehole.com/tips/using-the-silver-searcher-with-vim/
" [8]: https://robots.thoughtbot.com/faster-grepping-in-vim

" I got this from <https://noahfrederick.com/log/vim-streamlining-grep>.  TODO: consider
" this: <https://redd.it/fu9v18>.
cnorea <expr> grep  getcmdtype() == ':' && getcmdline() =~# '^grep'  ? 'sil gr'  : 'grep'
cnorea <expr> gre   getcmdtype() == ':' && getcmdline() =~# '^gre'   ? 'sil gr'  : 'gre'
cnorea <expr> gr    getcmdtype() == ':' && getcmdline() =~# '^gr'    ? 'sil gr'  : 'gr'
cnorea <expr> lgrep getcmdtype() == ':' && getcmdline() =~# '^lgrep' ? 'sil lgr' : 'lgrep'
cnorea <expr> lgre  getcmdtype() == ':' && getcmdline() =~# '^lgre'  ? 'sil lgr' : 'lgre'
cnorea <expr> lgr   getcmdtype() == ':' && getcmdline() =~# '^lgr'   ? 'sil lgr' : 'lgr'

" Normally, <Tab> and <C-I> always perform the same action in Vim, because terminals
" normally send the same byte for <Tab> and <C-I>.  I like to remap <Tab> while keeping
" <C-I> unchanged.  This is accomplished by configuring xterm to send "ÿ" when <C-I> is
" pressed, so we can distinguish <Tab> and <C-I>.
if !has('gui_running')
   nnoremap ÿ <C-I>
   nnoremap <silent> <Tab> :<C-U>call <SID>CycleHorizontally()<CR>
else
   " TODO?  I think this isn't straightforward in gvim either and I don't care too much
   " right now.
endif

function! s:CycleHorizontally()
   if winnr('$') == 1
      return
   elseif v:count > 0
      execute 'normal!' v:count .. "\<C-W>w\<C-W>_"
   elseif win_screenpos(winnr('#'))[1] != win_screenpos(0)[1]
      wincmd p
   elseif win_screenpos(winnr('$'))[1] == 1
      if winnr() == winnr('$')
         let new_winnr = 2
      else
         let new_winnr = winnr() + 1
      endif
      wincmd H
      execute new_winnr .. 'wincmd w'
      wincmd _
   elseif winnr() == winnr('l')
      while winnr() != winnr('h') | wincmd h | endwhile
   else
      wincmd l
   endif
endfunction

nnoremap j gj
nnoremap k gk

" Heresy refined.  Courtesy of Steve Losh (found in a discussion of his Vim configuration
" on Hacker News: <https://news.ycombinator.com/item?id=3252644>).
inoremap <C-A> <Home>
inoremap <C-E> <End>

" Use the semicolon key to enter Ex commands.  The key is available thanks to
" [clever-f.vim](https://github.com/rhysd/clever-f.vim).  Also see
" <https://stevelosh.com/blog/2010/09/coming-home-to-vim/>.
noremap ; :
" For consistency, also support opening the command-line window with `q;`.  Don't `nmap`
" because that also adds an operator-pending mapping which incurs a delay when using `gqq`
" (format the current line).  TODO: there's still a delay when using `q` to stop recording
" a macro.
nnoremap q; q:
vnoremap q; q:

nnoremap , <Cmd>echo<CR>

" Use . (`:h .`) in visual mode to repeat the last change for each selected line (see
" `:h :normal-range`).  This often doesn't work as expected.  Try repeating `dd`.  The
" mapping doesn't override anything though, so it's probably still worth keeping.  Picked
" up from <https://reddit.com/comments/3y2mgt//cya0x04>.
vnoremap . :norm .<CR>

nnoremap <expr> <S-Tab> &foldlevel ? 'zm' : 'zR'

" Switch windows more easily.
nnoremap <C-J> <C-W>w
nnoremap <C-K> <C-W>W

" Control+Q just does the same as Control+V by default; use it to close windows.
nnoremap <C-Q> <Cmd>x<CR>
inoremap <C-Q> <Esc>ZZ

" Correct typos in insert mode.  Copied from <https://castel.dev/post/lecture-notes-1/>.
inoremap <C-L> <C-G>u<Esc>[s1z=`]a<C-G>u

" Traverse the change list more quickly.  <C-P> and <C-N> are just duplicates of k and j
" by default.  I added zv to also open just enough folds after moving the cursor to make
" the current line visible.  Directly using the g; and g, mappings already seems to do
" that but the new mappings (without zv) don't for some reason.
nnoremap <C-P> g;zv
nnoremap <C-N> g,zv

" This is alike Emacs, Mutt, Newsboat, ncmpcpp, and cmus.
cnoremap <C-G> <C-U><BS>

let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0
" Toggle the quickfix window.
nmap <C-F> <Plug>(qf_qf_toggle_stay)

" Search and highlight but don't jump.  See <https://stackoverflow.com/a/60583995>.
nnoremap <silent> <C-B> :let @/ = '\<' .. expand('<cword>') .'\>' \| set hlsearch<CR>

function! s:MaximizeWindow()
   let curwin = winnr()
   if win_screenpos(winnr('$'))[1] == 1
      wincmd t
      wincmd H
   else
      for _ in range(winnr('$'))
         execute winnr('$') .. 'wincmd w'
         wincmd K
      endfor
   endif
   execute curwin .. 'wincmd w'
   wincmd _
endfunction
nnoremap <Bslash> <Cmd>call <SID>MaximizeWindow()<CR>

" This is a cursed variation of <https://stackoverflow.com/a/45591177> that I wrote
" because I wanted to disable 'equalalways'.
nnoremap <silent> + :set ead=hor ea ead=ver \| sp \| q \| set noea<CR>
set noea

function! s:IsVerticallySplit()
   let col = win_screenpos(0)[1]
   return len(filter(range(1, winnr('$')), {_, nr -> win_screenpos(nr)[1] == col})) > 1
endfunction

function! s:ToggleHeight()
   if v:count
      execute v:count .. 'wincmd _'
   else
      let wh = winheight(0)
      wincmd _
      if winheight(0) == wh
         if s:IsVerticallySplit()
            set ead=hor ea ead=ver | sp | q | set noea
         endif
      endif
   endif
endfunction
nnoremap <silent> ý :call <SID>ToggleHeight()<CR>

nnoremap <Space>1 <Cmd>normal! 1<C-W>w<C-W>_<CR>
nnoremap <Space>2 <Cmd>normal! 2<C-W>w<C-W>_<CR>
nnoremap <Space>3 <Cmd>normal! 3<C-W>w<C-W>_<CR>
nnoremap <Space>4 <Cmd>normal! 4<C-W>w<C-W>_<CR>
nnoremap <Space>5 <Cmd>normal! 5<C-W>w<C-W>_<CR>
nnoremap <Space>6 <Cmd>normal! 6<C-W>w<C-W>_<CR>
nnoremap <Space>7 <Cmd>normal! 7<C-W>w<C-W>_<CR>
nnoremap <Space>8 <Cmd>normal! 8<C-W>w<C-W>_<CR>
nnoremap <Space>9 <Cmd>normal! 9<C-W>w<C-W>_<CR>

" Always go forward with n and backward with N.  Remove the cognitive dissonance after
" forgetting whether the last search was done with '/' or '?'.  See
" <https://stackoverflow.com/q/18523150> and <https://vi.stackexchange.com/q/2365>.
" :noremap adds the mapping for normal, visual, select and operator-pending mode.
noremap <expr> n 'Nn'[v:searchforward]
noremap <expr> N 'nN'[v:searchforward]

" vim-easy-align
" Operator starting interactive EasyAlign.  Normal and visual mode.
nmap gl <Plug>(EasyAlign)
xmap gl <Plug>(EasyAlign)

function! s:UpdateOrEnableGitGutter()
   if !g:gitgutter_enabled
      " Some of vim-gitgutter's commands don't work after :GitGutterEnable when not also
      " running :GitGutter (e.g. :GitGutterStageHunk).
      return ':GitGutterEnable | GitGutter'
   else
      return ':GitGutter'
   end
endfunction
nnoremap <silent> <expr> <Space>g <SID>UpdateOrEnableGitGutter() .. '<CR>'
nnoremap <silent> <Space>G :GitGutterDisable<CR>
nnoremap <silent> cog :GitGutterToggle<CR>

nnoremap <silent> <Space>c :Git commit<CR>
nnoremap <silent> <Space>C :Git commit --amend<CR>

" Mappings for commands from junegunn's fzf.vim plugin.  Most commands support CTRL-T,
" CTRL-X, and CTRL-V key mappings to open in a new tab, a new split, or a new vertical
" split respectively.
nnoremap U <Cmd>Windows<CR>
nnoremap <Space>f <Cmd>Files<CR>
nnoremap <Space>F <Cmd>Files ~/projects<CR>
nnoremap <Space>l <Cmd>Buffers<CR>
nnoremap <silent> <Space>a :Rg \b<C-R><C-W>\b<CR>
nnoremap <silent> <Space>A :RG <C-R><C-W><CR>
nnoremap <Space>r <Cmd>Rg<CR>
nnoremap <Space>R <Cmd>RG<CR>
nnoremap <Space>; <Cmd>History:<CR>
nnoremap <Space>/ <Cmd>History/<CR>
nnoremap <Space>s <Cmd>Snippets<CR>
nnoremap <Space>d <Cmd>GF?<CR>
" nnoremap <silent> <Space>c :Commits<CR>
" nnoremap <silent> <Space>C :BCommits<CR>

command! -bang Projects call fzf#run(fzf#wrap(
   \ {'source': 'fd --strip-cwd-prefix --maxdepth 1', 'dir': '~/projects'}, <bang>0
\ ))
nnoremap <silent> <Space>p :Projects<CR>

let g:fzf_layout = {
   \ 'window': {'width': 163, 'height': 31, 'yoffset': 0, 'border': 'sharp'}
\ }
let g:fzf_vim = {'buffers_jump': 1, 'preview_window': []}

nnoremap <silent> <Space>m :Neomake<CR>
nnoremap <silent> <Space>M :Neomake!<CR>

nnoremap <silent> <Space>u :silent update<CR>
nnoremap <silent> <Space>U :Gwrite<CR>

nnoremap <silent> <C-S> :<C-U>silent update \| echo<CR>
inoremap <silent> <C-S> <Esc>:silent update \| echo<CR>

" Remap <CR>
" nnoremap <CR> to stop 'hlsearch' highlighting and clear any message displayed on the
" command-line (idea from http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches).
" Remapping <CR> is complicated because care needs to be taken not to break its normal
" function in the command-line window or the quickfix windows (:copen, :lopen).  Fugitive
" also uses <CR> in some of its windows but this doesn't seem to override that mapping (I
" guess fugitive's mapping is added later).
" See <https://redd.it/47ivpz>, <https://stackoverflow.com/a/16360104>, :h :map-local and
" :h :map-silent.
"
" I was using this:
"
"    function! s:RemapEnter()
"       if empty(&buftype) || &buftype ==# 'help'
"          nnoremap <buffer> <silent> <CR> :noh<Bar>:echo<CR>
"       else
"          silent! nunmap <buffer> <CR>
"       end
"    endfunction
"    autocmd vimrc_common BufEnter * call s:RemapEnter()
"
" However, all autocommand events seem to have some shortcomings when used to remap <CR>:
" *   BufReadPost isn't used for buffers without a file (try :new).
" *   Using BufEnter breaks the quickfix windows when entering them with :copen or :lopen.
"     because &buftype is still empty at that point.  It's also run needlessly often.
" *   BufNew is also run too early, I think.
" *   I don't understand when exactly BufAdd is triggered but I think it's also run too
"     early.
" *   Using BufNewFile in addition to BufReadPost still doesn't work for :new (but does
"     for `:e foo` when foo doesn't exist).
" I think using BufEnter, BufReadPost and BufNewFile might work (BufEnter is executed for
" :new and running s:RemapEnter() on the other events seems to unbreak the quickfix
" windows).
" Either way, using the <expr> special argument seems like a much better approach that
" avoids this mess.  See :h <expr> and :h expression-syntax.
function! s:OnEnter()
   let filetypes = [ 'man' ]
   if empty(&buftype) || &buftype ==# 'help' || index(filetypes, &filetype) != -1
      return ':silent noh:echo'
   else
      return ''
   end
endfunction
nnoremap <silent> <expr> <CR> <SID>OnEnter()
" This works around E481 caused by :noh not accepting a range (just try :noh in visual
" mode).  TODO: it feels pretty inelegant, though.
xnoremap <silent> <expr> <CR> '<Esc>' .. <SID>OnEnter() .. 'gv'

function! s:LeftRightWindowMove()
   let direction = winnr() != winnr('l') ? 'l' : 'h'
   let target = winnr(direction)
   if target == winnr() || !s:IsVerticallySplit()
      execute 'wincmd' toupper(direction)
   else
      call win_splitmove(winnr(), target)
   endif
endfunction
nnoremap <silent> <Bar> :call <SID>LeftRightWindowMove()<CR>
nnoremap <silent> <C-\> :call <SID>LeftRightWindowMove()<CR>

function! s:Dwmify()
   if win_screenpos(winnr('$'))[1] == 1
      wincmd H
      return
   endif
   if winnr() == 1 && win_screenpos(2)[1] != 1
      call s:CycleHorizontally()
   endif
   let old_winnr = winnr()
   call s:MaximizeWindow()
   1wincmd x
   wincmd t
   wincmd H
   execute old_winnr .. 'resize'
endfunction
nnoremap <silent> <Nul> :call <SID>Dwmify()<CR>
nnoremap <silent> <A-CR> :call <SID>Dwmify()<CR>

nnoremap <silent> <BS> :set lz<Bar>exe "normal! <C-V><C-W>W<C-V><C-W>_"<Bar>set nolz<CR>
nnoremap <silent> <C-L> :set lz<Bar>exe "normal! <C-V><C-W>w<C-V><C-W>_"<Bar>set nolz<CR>

" After entering a window (WinEnter event) and if the previous window has a height of only
" a single line, change the previous window's height to 0.  This only makes sense when
" 'winminheight' is 0, which is not the default.  XXX: Vim hasn't changed any window
" heights yet when it executes this function.
function! s:RecollapsePreviousWindow()
   let prevWindow = winnr('#')

   if winheight(prevWindow) != 1
      return
   endif

   let columnId = win_screenpos(prevWindow)[1]

   " We use win_screenpos() to determine whether two windows are part of the same column.
   " When the window number argument is invalid it returns [0, 0].
   let firstWinOfCol = prevWindow - 1
   while win_screenpos(firstWinOfCol)[1] == columnId
      let firstWinOfCol = firstWinOfCol - 1
   endwhile
   let firstWinOfCol = firstWinOfCol + 1

   let lastWinOfCol = prevWindow + 1
   while win_screenpos(lastWinOfCol)[1] == columnId
      let lastWinOfCol = lastWinOfCol + 1
   endwhile
   let lastWinOfCol = lastWinOfCol - 1

   if firstWinOfCol == lastWinOfCol
      return
   endif

   " Are we in the same column as before?
   if columnId == win_screenpos(0)[1]
      let curWindow = winnr()
      " We moved down to the column's last window and that window has height 0.
      if curWindow == lastWinOfCol && curWindow > prevWindow && winheight(0) == 0
         let rowOffset = win_screenpos(0)[0] - win_screenpos(prevWindow)[0]
         " If we moved down (e.g.) 3 windows and the row offset is 4, then all the windows
         " between the previously and newly focused one have height 0.  The previously
         " focused window has height 1, which is why we subtract 1 from rowOffset.
         if curWindow - prevWindow == rowOffset - 1
            " Vim's default behavior is all we need in this case.
            return
         endif
      endif
   endif

   " Shrinking a window increases the height of the window below (which is also the
   " numerical successor in terms of winnr()) by an equal amount.  The exception to this
   " is (necessarily) the column's bottommost window.  We don't set the height of that
   " window to 0 because doing so would just enlarge the window above again.
   for i in range(prevWindow, lastWinOfCol - 1)
      if winheight(i) == 1
         execute i .. 'resize 0'
      elseif winheight(i) > 1
         return
      endif
   endfor

   " Vim hasn't changed the newly entered window's height yet when this function is
   " executed.
   if winheight(0) == 0
      resize 1
   endif

   " It wasn't sufficient to (implicitly) enlarge windows below prevWindow.  Only now do
   " we consider enlarging windows above prevWindow.  This is in line with how Vim selects
   " what window to shrink when increasing another window's height.  When resizing a
   " window, Vim prefers to accommodate the height of windows below if possible.
   if winheight(lastWinOfCol) == 1
      for i in range(prevWindow - 1, firstWinOfCol, -1)
         if winheight(i) != 0
            execute i .. 'resize' (winheight(i) + 1)
            return
         endif
      endfor
   endif
endfunction
autocmd vimrc_common WinEnter * call s:RecollapsePreviousWindow()

inoremap <Tab> <Esc>
inoremap <Nul> <C-X><C-O>

" Do something with Alt.  Maybe just having some normal mode commands in insert mode would
" be cool.
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>

function! s:LongJumpBackward()
   let [jumps, jump_pos] = getjumplist()
   for i in reverse(range(0, jump_pos - 1))
      if !bufexists(jumps[i].bufnr)
         continue
      endif
      if jumps[i].bufnr != bufnr()
         execute 'normal!' (jump_pos - i) .. "\<C-O>"
         return
      endif
   endfor
endfunction
nnoremap <silent> <A-o> :call <SID>LongJumpBackward()<CR>

function! s:LongJumpForward()
   let [jumps, jump_pos] = getjumplist()
   if jump_pos >= len(jumps) - 1
      return
   endif
   for i in range(jump_pos + 1, len(jumps) - 1)
      if !bufexists(jumps[i].bufnr)
         continue
      endif
      if jumps[i].bufnr != bufnr()
         break
      endif
   endfor
   let jump_count = i - jump_pos
   let increment = 1
   for j in range(i + 1, len(jumps) - 1)
      if !bufexists(jumps[j].bufnr)
         let increment += 1
      elseif jumps[j].bufnr == jumps[i].bufnr
         let jump_count += increment
         let increment = 1
      else
         break
      endif
   endfor
   execute 'normal!' jump_count .. "\<C-I>"
endfunction
nnoremap <silent> <A-i> :call <SID>LongJumpForward()<CR>

nnoremap <A-h> gT
nnoremap <A-l> gt

function! s:QuickfixMoveOrCc(move_command)
   try
      execute v:count .. a:move_command
   catch /^Vim\%((\a\+)\)\=:E42:/
      " Ignore E42
   catch /^Vim\%((\a\+)\)\=:E553:/
      cc
   endtry
endfunction

nnoremap <silent> <A-j> :<C-U>call <SID>QuickfixMoveOrCc('cbelow')<CR>
nnoremap <silent> <A-k> :<C-U>call <SID>QuickfixMoveOrCc('cabove')<CR>

function! s:RotateToEdge()
   if v:count
      execute v:count .. 'wincmd r'
   elseif winnr() == winnr('k')
      wincmd R
   else
      while winnr() != winnr('k')
         wincmd R
      endwhile
   endif
endfunction
nnoremap <silent> <A-r> :<C-U>silent! call <SID>RotateToEdge()<CR>

function! s:Split() abort
   if winnr('$') == 1 && &tw <= 90 && &columns >= 195 | vs | else | sp | endif
   Dirvish %
endfunction
nnoremap <silent> _ :call <SID>Split()<CR>
nnoremap <silent> <C-_> :call <SID>Split()<CR>

command! Mail new | set ft=mail

" This makes it so that delimitMate is loaded before vim-endwise, because it doesn't work
" otherwise.  The loading order used to work out by default, but it changed when I grouped
" Vim plugins into two directories (57613a3152319696e8dc73e2a793aa3c2e3a14e9).
packadd! delimitMate
