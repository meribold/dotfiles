setl spell
setl omnifunc=mailcomplete#Complete

function! s:OnExit(job_id, code, event) dict
   if a:code == 0
      " NeoMutt successfully sent the mail.  Get rid of the terminal buffer and window.
      " We can't use plain `bd!` because the terminal window may no longer have focus.
      execute 'bd!' s:bufnr
      " Quit if we succeeded in sending the email and there's only one buffer left.
      if len(getbufinfo({'buflisted': 1})) == 1
         quit
      endif
   else
      " We didn't send the mail.  Go back to the buffer with the message.  FIXME: we
      " probably shouldn't rely on a [plugin][1].
      execute 'Bd!' s:bufnr
   endif
endfunction
" [1]: https://github.com/moll/vim-bbye
" [2]: https://github.com/neovim/neovim/issues/4291
" [3]: https://vi.stackexchange.com/q/10292
" [4]: https://redd.it/46g5wy
" [5]: https://github.com/neovim/neovim/issues/5176

function! s:SendMail()
   let l:message_file = expand('%')
   if l:message_file != ''
      update
   else
      " Cope with the buffer not having an associated file.  TODO: delete this file if we
      " succeed in sending the mail?
      let l:message_file = system('mktemp')
      execute 'w!' l:message_file
   endif
   enew
   " Tell NeoMutt to use `true` as the editor.  This makes it show the compose menu
   " directly instead of starting Vim inside of Vim.  Also don't use the curses pinentry
   " program.  There seem to be some issues when using it from NeoMutt inside Vim inside
   " screen(1).
   call termopen('VISUAL=true PINENTRY_USER_DATA=gtk neomutt ' .
               \ "-e 'set postpone=no sidebar_visible=no assumed_charset=utf-8' " .
               \ "-H " . l:message_file, {'on_exit': function('s:OnExit')})
   let s:bufnr = bufnr('%')
   startinsert
endfunction

nnoremap <buffer> <silent> <C-H> :<C-U>call <SID>SendMail()<CR>

nnoremap <buffer> <silent> <localleader>f gg/From:<CR>:nohlsearch<CR>4lC: 
nnoremap <buffer> <silent> <localleader>t gg/To:<CR>:nohlsearch<CR>2lC: 
nnoremap <buffer> <silent> <localleader>c gg/Cc:<CR>:nohlsearch<CR>2lC: 
nnoremap <buffer> <silent> <localleader>b gg/Bcc:<CR>:nohlsearch<CR>3lC: 
nnoremap <buffer> <silent> <localleader>s gg/Subject:<CR>:nohlsearch<CR>7lC: 
