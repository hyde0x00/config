"
" https://github.com/samjwill/vim-auto-nohlsearch
"

if (!exists("g:auto_nohlsearch_enabled"))
  let g:auto_nohlsearch_enabled = v:true
endif

function! s:toggle_enabled()
  let g:auto_nohlsearch_enabled = !g:auto_nohlsearch_enabled
  set hlsearch
endfunction

command AutoNohlsearchToggle call <SID>toggle_enabled()

"------------------------------------------------------------------------------

"Turn off search highlighting once done searching
let s:enter_was_pressed = v:false

function! s:set_hlsearch(enable)
  if (g:auto_nohlsearch_enabled == v:true)
    if (a:enable)
      set hlsearch
    else
      set nohlsearch
    endif
  endif
endfunction

function! s:handle_cursor_moved()
  if &hlsearch == 0 "See :h expr-option
    return
  endif
  let last_search = @/
  if last_search != ""
    let cursor_pos = [line("."), col(".")]
    "Limit search to current line, starting with character under cursor
    let pos_of_next_match = searchpos(last_search, "cnz", cursor_pos[0])
    if cursor_pos != pos_of_next_match
      call <SID>set_hlsearch(v:false)
    else
      call <SID>set_hlsearch(v:true) "Update CurSearch on any move
    endif
  endif
endfunction

function! s:handle_cmdline_leave()
  if (!s:enter_was_pressed)
    call <SID>set_hlsearch(v:false)
  else
    let s:enter_was_pressed = v:false
    call <SID>set_hlsearch(v:true)
  endif
endfunction

function! s:handle_enter_pressed_in_cmdline()
  let s:enter_was_pressed = v:true
  return "\<CR>"
endfunction

function! s:set_enter_was_pressed(was_pressed)
  let s:enter_was_pressed = a:was_pressed
endfunction

function! s:handle_cmdwin_enter()
  " Needs to call a function since script-local variables cannot be accessed
  " directly in mappings.
  nnoremap <CR> :call <SID>set_enter_was_pressed(v:true)<CR><CR>
endfunction

function! s:handle_cmdwin_leave()
  nunmap <CR>
endfunction

augroup AUTO_NOHLSEARCH_CMDS | autocmd!
  "See :h cmdwin-char and :h file-pattern. Maps to ? and / searches.
  autocmd CmdlineChanged [\/\?] call <SID>set_hlsearch(v:true)
  autocmd CmdlineLeave [\/\?] call <SID>handle_cmdline_leave()
  autocmd CmdwinEnter [\/\?] call <SID>handle_cmdwin_enter()
  autocmd CmdwinLeave [\/\?] call <SID>handle_cmdwin_leave()
  autocmd CursorMoved * call <SID>handle_cursor_moved()
  autocmd InsertEnter * call <SID>set_hlsearch(v:false)
  if has('nvim')
    autocmd TermEnter * call <SID>set_hlsearch(v:false)
  endif
augroup end

cnoremap <silent><expr> <CR> <SID>handle_enter_pressed_in_cmdline()

noremap <silent> n n<CMD>call <SID>set_hlsearch(v:true)<CR>
noremap <silent> N N<CMD>call <SID>set_hlsearch(v:true)<CR>
noremap <silent> * *<CMD>call <SID>set_hlsearch(v:true)<CR>
noremap <silent> # #<CMD>call <SID>set_hlsearch(v:true)<CR>
noremap <silent> g* g*<CMD>call <SID>set_hlsearch(v:true)<CR>
noremap <silent> g# g#<CMD>call <SID>set_hlsearch(v:true)<CR>

"
" https://vim.fandom.com/wiki/Search_for_visually_selected_text
"
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
  \<CMD>call <SID>set_hlsearch(v:true)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
  \<CMD>call <SID>set_hlsearch(v:true)<CR>

vnoremap g* <Nop>
vnoremap g# <Nop>
