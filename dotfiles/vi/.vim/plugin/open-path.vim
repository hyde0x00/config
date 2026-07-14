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

function! s:path_exists(path)
  return filereadable(a:path) || isdirectory(a:path)
endfunction

function! s:find_file_or_dir(text)
  if empty(a:text)
    return ''
  endif
  let path = expand(fnameescape(a:text))
  if path[0] ==# '/'
    if s:path_exists(path)
      return path
    endif
  endif
  let buffer_dir = expand('%:p:h')
  if !empty(buffer_dir)
    let relative_to_buf = buffer_dir . '/' . path
    if s:path_exists(relative_to_buf)
      return relative_to_buf
    endif
  endif
  let relative_to_pwd = getcwd() . '/' . path
  if s:path_exists(relative_to_pwd) 
    return relative_to_pwd
  endif
  return ''
endfunction

function! s:open(path)
  let path = s:find_file_or_dir(a:path)
  if empty(path)
    return 0
  endif
  let os_type = trim(system('uname'))
  if os_type == 'Darwin'
    let cmd = 'open'
  else
    let cmd = 'xdg-open'
  endif
  call system(cmd . ' ' . shellescape(path))
  redraw!
  return 1
endfunction

function! s:open_cursor_path()
  let path = expand('<cfile>')
  if empty(path)
    call s:err('No file or directory name under cursor')
    return
  endif
  if !s:open(path)
    call s:err('Not a file or directory')
  endif
endfunction

function! s:open_visual_path()
  let selected_text = s:get_visual_selection_one_line()
  if empty(selected_text) 
    return
  endif
  let opened = 0
  for path in [selected_text, trim(selected_text, '', 1)]
    if !opened
      let opened = s:open(path)
    endif
  endfor
  if !opened
    call s:err('Not a file or directory')
  endif
endfunction

command! -nargs=0 OpenPath call s:open_cursor_path()
command! -nargs=0 -range OpenPathVisual call s:open_visual_path()
