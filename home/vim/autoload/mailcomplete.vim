" This is based on (that is, mostly copy-pasted from) [here][1], but uses Khard [2] rather
" than GooBook [3].  Also see `:h 'omnifunc'`.  TODO: maybe prettify this a bit.  TODO:
" consider whether there's something worth stealing from how Greg Hurrell set up
" autocompletion.  See [4], [5], [6], etc.
function! mailcomplete#Complete(findstart, base)
   if a:findstart == 1
      let line = getline('.')
      let idx = col('.')
      while idx > 0
         let idx -= 1
         let c = line[idx]
         if c == ':' || c == '>'
            return idx + 2
         else
            continue
         endif
      endwhile
      return idx
   else
      return split(system('khard email -p --remove-first-line ' . a:base .
                        \ ' | awk -F "\t" ''{ print $2" <"$1">" }'''), '\n')
   endif
endfunction

" [1]: https://web.archive.org/web/20160915070551/http://www.recursivedream.com/blog/2012/auto-completing-google-contacts-in-vim
" [2]: https://github.com/scheibler/khard
" [3]: https://gitlab.com/goobook/goobook
" [4]: https://youtu.be/9zffUQsbxgE "Vim screencast #49: Sending email with vim"
" [5]: https://youtu.be/VBLh56J89do "Vim screencast #51: Composing email"
" [6]: https://youtu.be/BNnSjJOpXDk "Vim screencast #58: deoplete.nvim"
" [7]: https://github.com/wincent/wincent/blob/9350820fd0fe/roles/dotfiles/files/.vim/plugin/autocomplete.vim#L46-L74
" [8]: https://github.com/wincent/ycmd/commit/cb90aa61dcd8135351bb8afd7c39e90d653313c5
" [9]: https://github.com/fszymanski/deoplete-abook
