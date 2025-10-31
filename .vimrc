set shell=/run/current-system/sw/bin/bash
let mapleader = ","
"
"Plugins
call plug#begin('~/.vim/plugged')
"colourscheme
Plug 'morhetz/gruvbox'
"fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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
"rainbow parens
Plug 'luochen1990/rainbow'
"nix syntax highlighting
Plug 'LnL7/vim-nix'
"LSP
Plug 'neovim/nvim-lspconfig'
"Rust
Plug 'mrcjkb/rustaceanvim'
Plug 'hrsh7th/cmp-nvim-lsp'
"completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

"tab autocmpletion
" Plug 'ervandew/supertab'

Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

let g:rainbow_active = 1

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
let g:vimtex_compiler_method = "tectonic"
let g:vimtex_view_method = 'zathura'

autocmd FileType tex nmap <leader>c  <plug>(vimtex-compile)
autocmd FileType tex nmap <leader>o  <plug>(vimtex-compile-output)
autocmd FileType tex nmap <leader>p  <plug>(vimtex-view)
autocmd FileType tex nmap <leader>s  <plug>(vimtex-status)
autocmd FileType tex nmap <leader>e  <plug>(vimtex-errors)
autocmd FileType tex nmap <leader>m  <plug>(vimtex-context-menu)
autocmd FileType tex nmap <leader>t  <plug>(vimtex-toc-toggle)

autocmd FileType tex nnoremap <F3> :w !detex \| wc -w<CR>
" autocmd InsertLeave *.tex silent write 
" autocmd TextChanged *.tex silent write 

" autocmd FileType * exec("setlocal dictionary+=/home/kelton/.vim/dictionaries/".expand('<amatch>'))
au BufRead,BufNewFile *.tex set spell spelllang=en_us
au BufRead,BufNewFile *.bib set spell spelllang=en_us
au BufRead,BufNewFile *.mlw set filetype=why3
"colour scheme
try
    colorscheme gruvbox
catch
endtry

"set background=light   " Setting light mode

"essentials
"bells
set noerrorbells
set novisualbell
" Enable filetype plugins
filetype plugin on
filetype indent on
"Syntax highlighting
syntax enable
"omnicomplete
set omnifunc=syntaxcomplete#Complete
"absolute line numbers
set number
set norelativenumber
" Use spaces instead of tabs
set expandtab
" enable smarts
set smarttab
set shiftwidth=2
set tabstop=2
" Linebreak on 500 characters
set lbr
set tw=500

set undofile
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
set history=500
set hls "highlight search results

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
set statusline+=%=
set statusline+=%y
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

" treestuff
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

au FileType vimwiki :RainbowToggleOff
" fuck perl
au BufRead,BufNewFile *.pl            set filetype=prolog

"require('lspconfig').rust_analyzer.setup {
"  -- Other Configs ...
    "  settings = {
    "    ["rust-analyzer"] = {
    "      -- Other Settings ...
    "      procMacro = {
    "        ignored = {
    "            leptos_macro = {
    "                -- optional: --
    "                -- "component",
    "                "server",
    "            },
    "        },
    "      },
    "    },
    "  }

      " if client.resolved_capabilities.document_highlight then
      "   vim.api.nvim_exec([[
      "     hi LspReferenceRead cterm=bold ctermbg=yellow guibg=LightYellow
      "     hi LspReferenceText cterm=bold ctermbg=yellow guibg=LightYellow
      "     hi LspReferenceWrite cterm=bold ctermbg=yellow guibg=LightYellow
      "     augroup lsp_document_highlight
      "       autocmd!
      "       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      "       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      "     augroup END
      "   ]], false)
      " end
    "}

"lsp options
" LSP Configs
lua << EOF
    local cmp = require'cmp'
    cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
    
   
    require('nvim-tree').setup()
    local nvim_lsp = require('lspconfig')
    local on_attach = function(client, bufNumber)
      vim.api.nvim_buf_set_option(bufNumber, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufNumber, ...)
      end

      local opts = { noremap=true, silent=true }
      buf_set_keymap('n', '<leader>qf', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    end

    for _, lsp in ipairs({'hls', 'pyright', 'jdtls', 'ccls', 'ocamllsp' }) do
      nvim_lsp[lsp].setup({ on_attach = on_attach })
    end
EOF
set background =light
