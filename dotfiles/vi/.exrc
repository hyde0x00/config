map V :'v,.
"
map y !!cb copy!'vcb copy
map d !'vcb cut
map p :r!cb paste
map P :.-1r!cb paste
"
map Q 
map  
map  
map  
"
set autoindent
"set noignorecase
"
set directory=/tmp
set shell=/bin/sh
"
set ruler
set noerrorbells
set noflash
set nolock
set nowarn
set windowname
"
set cedit=
set filec=\	
"
map v !'v
map gg 1G
map ZQ :q!
"
map - :bp<CR>
map = :bn<CR>
map _ :bfirst<CR>
map + :buffers<CR>
"
map \d :w !diff % -
"
map \c !!clang-format!'vclang-format
map \f !!fmt!'vfmt
map \F !!fmt -128!'vfmt -128
