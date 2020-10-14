set shell=/bin/bash
let mapleader = ","
"Download vimplug on new install & install all plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugins
call plug#begin('~/.vim/plugged')
"colourscheme
Plug 'morhetz/gruvbox'
"fuzzy search
Plug 'junegunn/fzf.vim'
"easy commenting
Plug 'tpope/vim-commentary'
"Wiki
Plug 'vimwiki/vimwiki'
"haskell syntax highlighting
Plug 'neovimhaskell/haskell-vim'
"Latex integration
Plug 'lervag/vimtex'
"Async commands
Plug 'tpope/vim-dispatch'
"LSP
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" tab for completion
" Plug 'ervandew/supertab'
call plug#end()

" let g:SuperTabDefaultCompletionType = "<c-n>"
"tab manipulation
nmap <Tab><Tab> :tabn<CR>
nmap <Tab>q :q<CR>
nmap <Tab>e :tabe 
nmap <Tab>n :tabnew<CR>
"fzf new tab
nmap <Tab>f :call fzf#run({'sink' : 'tabe', 'down' : '50%', 'options' : '-m' })<CR>
"toggle between current and the last accessed tab
let g:lasttab = 1
nmap <Tab>l :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

"latex
let g:tex_flavor = "latex"

"colour scheme
try
    colorscheme gruvbox
catch
endtry

"essentials
"bells
set noerrorbells
set novisualbell
" Enable filetype plugins
filetype plugin on
filetype indent on
"Syntax highlighting
syntax enable
"absolute line numbers
set number
set norelativenumber
" Use spaces instead of tabs
set expandtab
" enable smarts
set smarttab
" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
set history=500

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

"close all windows but current
map <leader>wo  :only!<cr>

map <space> /

"8 lines to the cursor
set so=8
"locale stuff
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" Turn on the Wild menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.out
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" incremental search
set incsearch
" Don't redraw while executing macros 
set lazyredraw
"turn on magic
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Use Unix as the standard file type
set ffs=unix,dos,mac
" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry
" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Always show the status line
set laststatus=2
" Format the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c 
" Delete trailing white space on save
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh :call CleanExtraSpaces()
endif
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s

"coc.nvim
"tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
