hi clear
let g:colors_name = 'nothing'

" ---------------------------------------------------------------
" Scrolling redraw tearing/flicker fix:
" https://github.com/vim/vim/issues/10574#issuecomment-1205725448
"
" ctermbg should not be "none"
" ---------------------------------------------------------------
hi Normal             ctermfg=none  ctermbg=0     cterm=none
hi Comment            ctermfg=none  ctermbg=0     cterm=none
hi Todo               ctermfg=none  ctermbg=0     cterm=none
hi Constant           ctermfg=none  ctermbg=0     cterm=none
hi Special            ctermfg=none  ctermbg=0     cterm=none
hi Statement          ctermfg=none  ctermbg=0     cterm=none
hi Function           ctermfg=none  ctermbg=0     cterm=none
hi Identifier         ctermfg=none  ctermbg=0     cterm=none
hi PreProc            ctermfg=none  ctermbg=0     cterm=none
hi Type               ctermfg=none  ctermbg=0     cterm=none
hi Error              ctermfg=none  ctermbg=0     cterm=none
hi SignColumn         ctermfg=none  ctermbg=0     cterm=none
hi Folded             ctermfg=8     ctermbg=0     cterm=none
hi FoldColumn         ctermfg=8     ctermbg=0     cterm=none
hi LineNr             ctermfg=8     ctermbg=0     cterm=none
hi CursorLineNr       ctermfg=8     ctermbg=0     cterm=none
hi ColorColumn        ctermfg=none  ctermbg=234   cterm=none
hi CursorLine         ctermfg=none  ctermbg=233   cterm=none
hi CursorColumn       ctermfg=none  ctermbg=233   cterm=none
hi Search             ctermfg=15    ctermbg=5     cterm=none
hi IncSearch          ctermfg=15    ctermbg=2     cterm=none
hi CurSearch          ctermfg=15    ctermbg=2     cterm=none
hi LineLength         ctermfg=none  ctermbg=3     cterm=none
hi MatchParen         ctermfg=15    ctermbg=6     cterm=none
hi WhiteSpace         ctermfg=none  ctermbg=1     cterm=none
hi Visual             ctermfg=none  ctermbg=4     cterm=none
hi StatusLine         ctermfg=none  ctermbg=0     cterm=reverse
hi StatusLineTerm     ctermfg=none  ctermbg=0     cterm=reverse
hi StatusLineNC       ctermfg=8     ctermbg=0     cterm=reverse
hi StatusLineTermNC   ctermfg=8     ctermbg=0     cterm=reverse
hi VertSplit          ctermfg=8     ctermbg=0     cterm=none
hi TabLine            ctermfg=none  ctermbg=0     cterm=reverse
hi TabLineFill        ctermfg=8     ctermbg=0     cterm=reverse
hi TabLineSel         ctermfg=15    ctermbg=0     cterm=none
hi Title              ctermfg=none  ctermbg=none  cterm=none
hi Pmenu              ctermfg=none  ctermbg=0     cterm=none
hi PmenuSel           ctermfg=none  ctermbg=0     cterm=reverse
hi PmenuSbar          ctermfg=none  ctermbg=0     cterm=none
hi PmenuThumb         ctermfg=none  ctermbg=8     cterm=none
hi ErrorMsg           ctermfg=15    ctermbg=1     cterm=none
hi ModeMsg            ctermfg=none  ctermbg=0     cterm=none
hi MoreMsg            ctermfg=none  ctermbg=0     cterm=none
hi WarningMsg         ctermfg=none  ctermbg=0     cterm=none
hi Question           ctermfg=none  ctermbg=0     cterm=none
hi Conceal            ctermfg=8     ctermbg=0     cterm=none
hi EndofBuffer        ctermfg=8     ctermbg=0     cterm=none
hi NonText            ctermfg=8     ctermbg=0     cterm=none
hi Invisible          ctermfg=8     ctermbg=0     cterm=none
hi SpecialKey         ctermfg=8     ctermbg=0     cterm=none
hi Directory          ctermfg=none  ctermbg=0     cterm=none
hi QuickFixLine       ctermfg=none  ctermbg=0     cterm=none
hi WildMenu           ctermfg=8     ctermbg=0     cterm=reverse
hi Underlined         ctermfg=none  ctermbg=0     cterm=underline

hi SpellBad           ctermfg=9     ctermbg=0     cterm=none
hi SpellCap           ctermfg=none  ctermbg=0     cterm=none
hi SpellLocal         ctermfg=13    ctermbg=0     cterm=none
hi SpellRare          ctermfg=13    ctermbg=0     cterm=none

hi diffAdded          ctermfg=10    ctermbg=0     cterm=none
hi diffRemoved        ctermfg=9     ctermbg=0     cterm=none
hi diffLine           ctermfg=8     ctermbg=0     cterm=none
hi diffIndexLine      ctermfg=none  ctermbg=0     cterm=none
hi diffFile           ctermfg=none  ctermbg=0     cterm=none
hi diffNewFile        ctermfg=none  ctermbg=0     cterm=none
hi diffOldFile        ctermfg=none  ctermbg=0     cterm=none
hi diffChanged        ctermfg=none  ctermbg=0     cterm=none
hi diffSubname        ctermfg=none  ctermbg=0     cterm=none

hi DiffAdd            ctermfg=none  ctermbg=28    cterm=none
hi DiffChange         ctermfg=none  ctermbg=22    cterm=none
hi DiffText           ctermfg=none  ctermbg=28    cterm=none
hi DiffDelete         ctermfg=124   ctermbg=52    cterm=none

hi! link htmlBoldItalic              Normal
hi! link htmlBoldItalicUnderline     Normal
hi! link htmlBold                    Normal
hi! link htmlBoldUnderlineItalic     Normal
hi! link htmlBoldUnderline           Normal
hi! link htmlItalicBold              Normal
hi! link htmlItalicBoldUnderline     Normal
hi! link htmlItalic                  Normal
hi! link htmlItalicUnderlineBold     Normal
hi! link htmlItalicUnderline         Normal
hi! link htmlLink                    Normal
hi! link htmlUnderlineBoldItalic     Normal
hi! link htmlUnderlineBold           Normal
hi! link htmlUnderlineItalicBold     Normal
hi! link htmlUnderlineItalic         Normal
hi! link htmlUnderline               Normal
hi! link markdownBoldDelimiter       Normal
hi! link markdownBoldItalicDelimiter Normal
hi! link markdownBoldItalic          Normal
hi! link markdownBold                Normal
hi! link markdownCodeDelimiter       Normal
hi! link markdownItalicDelimiter     Normal
hi! link markdownItalic              Normal
hi! link markdownStrikeDelimiter     Normal
hi! link markdownStrike              Normal
