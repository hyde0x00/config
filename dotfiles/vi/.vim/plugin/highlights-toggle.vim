let g:highlight_linelength = get(g:, 'highlight_linelength', 0)
let g:highlight_matchparen = get(g:, 'highlight_matchparen', 0)
let g:highlight_whitespace = get(g:, 'highlight_whitespace', 0)

function! s:enable_match(key)
  let l:matches = {
  \ 'linelength': {'group': 'LineLength', 'pattern': '\%' . get(g:, 'linelength', 0) . 'v', 'priority': 100},
  \ 'whitespace': {'group': 'WhiteSpace', 'pattern': '\s\+$', 'priority': 10}
  \ }
  let l:match = l:matches[a:key]
  let s:{a:key} = matchadd(l:match.group, l:match.pattern, l:match.priority)
  let g:highlight_{a:key} = 1
endfunction

function! s:disable_match(key)
  if exists('s:' . a:key)
    silent! call matchdelete(s:{a:key})
  endif
  let g:highlight_{a:key} = 0
endfunction

function! s:toggle_linelength()
  if g:highlight_linelength
    call s:disable_match('linelength')
  else
    call s:enable_match('linelength')
  endif
endfunction

function! s:toggle_matchparen()
  if exists('g:loaded_matchparen')
    unlet g:loaded_matchparen
  endif
  runtime plugin/matchparen.vim
  let g:highlight_matchparen = !g:highlight_matchparen
  execute g:highlight_matchparen ? ':DoMatchParen' : ':NoMatchParen'
endfunction

function! s:toggle_whitespace()
  if g:highlight_whitespace
    call s:disable_match('whitespace')
  else
    call s:enable_match('whitespace')
  endif
endfunction

if g:highlight_linelength
  call s:enable_match('linelength')
endif

if !g:highlight_matchparen
  let g:loaded_matchparen = 1
endif

if g:highlight_whitespace
  call s:enable_match('whitespace')
endif

command! LineLengthToggle call s:toggle_linelength()
command! MatchParenToggle call s:toggle_matchparen()
command! WhiteSpaceToggle call s:toggle_whitespace()
