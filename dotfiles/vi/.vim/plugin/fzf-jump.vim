let s:cmds = {
\ 'find': 'f',
\ 'search': 's',
\ 'note': 'note',
\}

function! s:err(msg)
  echohl ErrorMsg | echo a:msg | echohl None
endfunction

function! s:get_visual_selection_one_line()
  if getpos("'<")[1] != getpos("'>")[1]
    silent normal! gv
    return ''
  else
    let old_reg = @"
    silent normal! gvy
    let text = get(split(@", '\r\?\n'), 0, '')
    let @" = old_reg
    return text
  endif
endfunction

function! s:fzf_jump(with_linenumber, cmd, ...)
  let result = system(a:cmd . ' -p ' . (a:0 ? join(a:1) : ''))[0:-2]
  let status = v:shell_error
  if status == 1
    call s:err('Nothing found')
    return
  endif 
  silent !clear -x
  redraw!
  if status == 2 || empty(result)
    echo 'Selection aborted'
    return
  endif 
  if status != 0 
    call s:err('Shell command status: ' . status)
    return
  endif
  if a:with_linenumber == v:false
    execute 'edit! ' . fnameescape(result)
  else
    let [file, lnum] = split(result, '\n')[1:2]
    execute 'edit! +' . lnum . ' ' . fnameescape(file)
  endif
endfunction

function! s:find_file(...)
  if !executable(s:cmds.find)
    call s:err('Executable not found: ' . s:cmds.find)
    return
  endif
  call s:fzf_jump(v:false, s:cmds.find, a:000)
endfunction

function! s:search_in_files(...)
  if !executable(s:cmds.search)
    call s:err('Executable not found: ' . s:cmds.search)
    return
  endif
  call s:fzf_jump(v:true, s:cmds.search, [&ignorecase ? '-c' : '-C'] + a:000)
endfunction

function! s:search_cursor_word()
  let word = expand('<cword>')
  if empty(word)
    call s:err('No word under cursor')
    return
  endif
  call s:search_in_files('-w', '--', shellescape(word))
endfunction

function! s:search_visual()
  let selected_text = s:get_visual_selection_one_line()
  if empty(selected_text)
    return
  endif
  call s:search_in_files('-F', '--', shellescape(selected_text))
endfunction

function! s:note(...)
  if !executable(s:cmds.note)
    call s:err('Executable not found: ' . s:cmds.note)
    return
  endif
  if a:0 == 0
    call s:fzf_jump(v:false, s:cmds.note)
  else
    call s:fzf_jump(v:true, s:cmds.note, [&ignorecase ? '-c' : '-C'] + a:000)
  endif
endfunction

function! s:search_cursor_word_in_notes()
  let word = expand('<cword>')
  if empty(word)
    call s:err('No word under cursor')
    return
  endif
  call s:note('-F', '--', shellescape(word))
endfunction

function! s:search_visual_in_notes()
  let selected_text = s:get_visual_selection_one_line()
  if empty(selected_text)
    return
  endif
  call s:note('-F', '--', shellescape(selected_text))
endfunction

command! -nargs=* -complete=dir Find call s:find_file(<f-args>)
command! -nargs=* -complete=file Search call s:search_in_files(<f-args>)
command! -nargs=0 SearchWord call s:search_cursor_word()
command! -nargs=0 -range SearchVisual call s:search_visual()

command! -nargs=* Note call s:note(<f-args>)
command! -nargs=0 NotesWord call s:search_cursor_word_in_notes()
command! -nargs=0 -range NotesVisual call s:search_visual_in_notes()
