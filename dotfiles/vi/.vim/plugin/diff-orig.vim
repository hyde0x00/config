function! s:err(msg)
  echohl ErrorMsg | echo a:msg | echohl None
endfunction

function! DiffOrig()
  let filename = expand('%')
  if !&modified
    echo 'No changes'
    return
  elseif empty(filename)
    call s:err('No file name')
    return
  elseif !filereadable(filename)
    call s:err('Not a file')
    return
  endif
  let orig = shellescape(filename, 1)
  let edit = tempname()
  silent! execute 'keepalt write! ' . edit
  silent! let is_diff = system('diff -q -- ' . orig . ' ' . edit)
  if empty(is_diff)
    echo 'No changes'
    call delete(edit)
    return
  endif
  try
    silent !clear -x
    silent execute '!diff -- ' . orig . ' ' . edit . ' | less -R'
  " catch /^Vim:Interrupt$/
  finally
    redraw!
    call delete(edit)
  endtry
endfunction

command! -nargs=0 DiffOrig call DiffOrig()
