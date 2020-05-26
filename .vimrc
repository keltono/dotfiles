"install vim plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"omni completetion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

call plug#begin('~/.vim/plugged')

"cool f/t highlighting
Plug 'unblevable/quick-scope'    
"colorscheme
Plug 'nanotech/jellybeans.vim'
"syntax checking
Plug 'vim-syntastic/syntastic'
"fish script
Plug 'dag/vim-fish'
"coq ide
Plug 'whonore/coqtail'
"requirement for coqtail
Plug 'let-def/vimbufsync'
"coq highlighting
Plug 'jvoorhis/coq.vim'
"fuzzy finding
Plug 'junegunn/fzf.vim'
"async build/commands
Plug 'tpope/vim-dispatch'
"commenting
Plug 'tpope/vim-commentary'
"general tweaks
Plug 'tpope/vim-sensible'
"git interface
Plug 'tpope/vim-fugitive'
"github fugative addon 
Plug 'tpope/vim-rhubarb'
"latex
Plug 'lervag/vimtex'
"tab autocompletion
Plug 'ervandew/supertab'
"wiki files
Plug 'vimwiki/vimwiki'

Plug 'mhinz/vim-startify'

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': './install.sh'
"     \ }
call plug#end()


try
colorscheme jellybeans
catch
endtry

set visualbell

"Statusline stuff
" Always show the status line
set laststatus=2

set statusline+=%#PmenuSel#
set statusline+=%{FugitiveStatusline()}
set statusline+=%#Normal#
set statusline+=\ %r%{getcwd()}%h\  
set statusline+=%m\  
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\[%{&fileformat}\]
set statusline+=\ L%l:C%c 
set statusline+=%#warningmsg#
set statusline+=\ \ %{SyntasticStatuslineFlag()}
set statusline+=\  


"syntastic stuff
let g:syntastic_ocaml_checkers = ['merlin']
let g:syntastic_tex_checkers = ['']
let g:syntastic_python_checkers = ['']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

au FileType ocaml call SuperTabSetDefaultCompletionType("<c-x><c-o>")

set nu 
highlight LineNr ctermfg=blue

autocmd TextChanged *.* silent write 
autocmd InsertLeave *.tex silent write 

let g:table_mode_corner='+'

let g:vimwiki_list = [{'path': '~/.vimwiki/',
                      \ 'syntax': 'default', 'ext': '.wiki'}]

let mapleader = ","
"fzf.vim keybindings
nmap <Leader>f :GFiles<CR> 
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>

"tabstuff
nmap <Tab><Tab> :tabn<CR>
nmap <Tab>c :tabclose<CR>
nmap <Tab>q :q<CR>
nmap <Tab>e :tabe
nmap <Tab>p :tabp<CR>
nmap <Tab>n :tabnew<CR>
"fzf tabedit
nmap <Tab>f :call fzf#run({'sink' : 'tabe', 'down' : '50%', 'options' : '-m' })<CR>

"make curr file
nmap <Leader>m :Make<CR>

" Enable folding
set foldmethod=indent
set foldlevel=99 "fold with za

autocmd FileType * exec("setlocal dictionary+=/home/kelton/.vim/dictionaries/".expand('<amatch>'))
set completeopt=menuone,longest,preview
set complete+=k

let g:vimtex_mappings_enabled = 0
let g:javascript_plugin_flow = 1

"vimtex config
let g:vimtex_view_general_viewer = 'evince'

set nocompatible
filetype off

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

set so=8

let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" Don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set t_vb=
set tm=500

syntax enable


set background=dark
set encoding=utf8

" set nobackup
" set nowb
set noswapfile


set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/


" Specify the behavior when switching between buffers
try
set switchbuf=useopen,usetab,newtab
set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" Remap 0 to first non-blank character
map 0 ^
" " Move a line of text using ALT+[jk] or Command+[jk] on mac
" nmap <M-j> mz:m+<cr>`z
" nmap <M-k> mz:m-2<cr>`z
" vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
" vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for some filetypes ;)
" fun! CleanExtraSpaces()
"     let save_cursor = getpos(".")
"     let old_query = getreg('/')
"     silent! %s/\s\+$//e
"     call setpos('.', save_cursor)
"     call setreg('/', old_query) endfun
" endfun

" if has("autocmd")
" autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh :call CleanExtraSpaces()
" endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
nmap <c-h> 1z=]s
nmap <c-j> ]s


" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

nmap <Leader>t :MerlinTypeOf<CR>
"creates a pattern match based on the type being matched
nmap <Leader>md :MerlinDestruct<CR>
nmap <Leader>doc :MerlinDocument<CR>

set rtp+=/home/kelton/.opam/default/share/merlin/vim

nmap <Leader>n :lnext<CR>
nmap <Leader>p :lprevious<CR>

au! BufNewFile,BufRead QUESTIONS.txt setf vimwiki

" toggle terminal
let s:term_buf = 0
let s:term_win = 0

function! Term_toggle(height)
    if win_gotoid(s:term_win)
        hide
    else
        new terminal
        exec "resize ".a:height
        try
            exec "buffer ".s:term_buf
            exec "bd terminal"
        catch
            call termopen($SHELL, {"detach": 0})
            let s:term_buf = bufnr("")
            setlocal nocursorline " signcolumn=no
        endtry
        startinsert!
        let s:term_win = win_getid()
    endif
endfunction

nnoremap <silent><tab>t :call Term_toggle(15)<CR>
tnoremap <silent><tab>t <C-\><C-n>:call Term_toggle(15)<CR>

"latex
nmap <Leader>lp :Start! evince %:r.pdf<CR>
nmap <Leader>lc <plug>(vimtex-clean)
nmap <Leader>lC <plug>(vimtex-clean-full)
nmap <Leader>lv <plug>(vimtex-view)
nmap <Leader>ll :Start! pdflatex %<CR>
nmap <Leader>lo :Start! pdflatex %<CR>
nmap <Leader>le <plug>(vimtex-errors)

"coq
autocmd FileType coq setlocal commentstring=(*%s*) tabstop=2 shiftwidth=2
nnoremap <silent><leader>cS :CoqStart<CR>
nnoremap <silent><leader>n :CoqNext<CR>
nnoremap <silent><leader>u :CoqUndo<CR>
nnoremap <silent><leader>cq :Coq (input('Query: '))<CR>
nnoremap <silent><leader>cs :Coq SearchAbout (input('Search: '))<CR>
autocmd FileType coq imap <C>n :call CoqNext()<CR>
autocmd FileType coq imap <C>u :call CoqUndo()<CR>

autocmd FileType latex let b:dispatch = 'pdflatex %'

au BufRead,BufNewFile *.txt set spell spelllang=en_us
au BufRead,BufNewFile *.md set spell spelllang=en_us

au BufRead,BufNewFile *.tex set spell spelllang=en_us
au BufRead,BufNewFile *.bib set spell spelllang=en_us

set expandtab
set tabstop=4

let g:LanguageClient_serverCommands = { 'haskell': ['hie-wrapper', '--lsp'] }
let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
