" -------
" Plugins
" -------
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
au VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

if filereadable(expand('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.local/share/vim/plugins')
  Plug 'tpope/vim-sleuth'
  Plug 'tyru/open-browser.vim'
  call plug#end()
endif

" ---------------------------------------------------------------------------
" Scrolling redraw tearing/flicker fix:
" https://github.com/vim/vim/issues/10574#issuecomment-1205725448
"
" Setting ttyscroll to 0 fixes Ctrl-U and Ctrl-D.
" Setting any color except NONE for Normal ctermbg fixes Ctrl-F.
"
" Enabling showcmd seems to fix both of those at once.
" ---------------------------------------------------------------------------
set ttyscroll=0

" ----------------
" General settings
" ----------------
set background=dark
colorscheme nothing
syntax off

set autoindent
set nosmartindent
set ignorecase
set smartcase
set incsearch
set nohlsearch

set mouse=
set hidden
set nojoinspaces
set nonumber
set norelativenumber
set nocursorline
set nocursorcolumn
set scrolloff=0
set signcolumn=no

set textwidth=0
set wrapmargin=0

set ruler
set noshowmode
set noshowcmd
set shortmess=aAcCItToOS
set display=lastline

" set spellcapcheck=
set spelllang=en_us,ru_ru

set splitright
set splitbelow

set nofoldenable
set foldlevelstart=99

set cot-=preview
set cpt=.,w,b,u

set pumheight=10
set wildmode=longest,list

set nolist
set fillchars=eob:\ ,stl:\ ,stlnc:\ ,lastline:\ ,vert:\│,diff:-,fold:-
set listchars=eol:\ ,tab:\¦\ ,space:\·,trail:·,nbsp:\_,precedes:‹,extends:› " precedes:«,extends:» eol:¬,tab:▸▸,»
" set showbreak=↳\ 

set nobackup
set noswapfile
set noundofile
set nowritebackup

set guifont=AdwaitaMono\ 14

set guioptions-=m
set guioptions-=r
set guioptions-=T

" ---------------
" Plugin settings
" ---------------
runtime! ftplugin/man.vim
set keywordprg=:Man

let g:loaded_netrwPlugin = 1

let g:linelength = 80
let g:highlight_linelength = 0
let g:highlight_matchparen = 0
let g:highlight_whitespace = 0

let g:openbrowser_message_verbosity = 0

" ------------
" Autocommands
" ------------
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o formatoptions-=t
autocmd FileType * setlocal autoindent nosmartindent nocindent indentexpr=

autocmd CmdwinEnter * set syntax=clear
autocmd VimEnter * :clearjumps
autocmd VimResized * wincmd =

autocmd BufEnter,BufNewFile,BufRead *.jai set filetype=c

" --------
" Mappings
" --------
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

nnoremap <C-C> <silent> <C-C>

nnoremap gd <Nop>
vnoremap gd <Nop>
nnoremap K <Nop>
vnoremap K <Nop>
cnoremap <S-TAB> <Nop>
inoremap <C-SPACE> <Nop>
inoremap <C-@> <Nop>
nnoremap Q q
nnoremap q <Nop>

nnoremap Y y$

nnoremap gy "+y
vnoremap gy "+y
nnoremap gp "+p
vnoremap gp "+p
nnoremap gP "+P
vnoremap gP "+P

nnoremap <silent> <Leader>W :write !sudo tee %<CR>:edit!<CR>
nnoremap <silent> <expr> <Leader>d DiffOrig()

nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)

nnoremap <silent> go :OpenPath<CR>
vnoremap <silent> go :OpenPathVisual<CR>

nnoremap <Leader>f :Find 
nnoremap <silent> <Leader>F :Find<CR>

nnoremap <Leader>s :Search 
nnoremap <silent> <Leader>S :Search<CR>
nnoremap <silent> gr :SearchWord<CR>
vnoremap <silent> gr :SearchVisual<CR>

nnoremap <Leader>n :Note 
nnoremap <silent> <Leader>N :Note<CR>
nnoremap <silent> gn :NotesWord<CR>
vnoremap <silent> gn :NotesVisual<CR>

function! ToggleOption(name)
  exec 'set ' . a:name . '!'
  exec 'set ' . a:name . '?'
endfunction

nnoremap <silent> <Leader>c :call ToggleOption('ignorecase')<CR>
nnoremap <silent> <Leader>m :call ToggleOption('magic')<CR>
nnoremap <silent> <Leader>w :call ToggleOption('wrap')<CR>
nnoremap <silent> <Leader>z :call ToggleOption('spell')<CR>
