" This is based on (that is, mostly copy-pasted from) [here][1], but uses Khard [2] rather
" than GooBook [3].  Also see `:h 'omnifunc'`.
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
