" Remove key mappings defined by a.vim.
nunmap <Leader>ih
nunmap <Leader>is
nunmap <Leader>ihn
iunmap <Leader>ih
iunmap <Leader>is
iunmap <Leader>ihn

if exists('g:loaded_lightline')
   set noshowmode
endif

" Use [vim-textobj-user][1] to define a text object for the most recently changed or
" yanked text.  For example, text that was just pasted can be indented with `=gp`.
" [1]: https://github.com/kana/vim-textobj-user
call textobj#user#plugin('', {
   \ 'text': {
   \    'select-function': 'textobj#select_changed',
   \    'select': 'gp',
   \ },
\ })
