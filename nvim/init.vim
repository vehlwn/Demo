call plug#begin()

Plug 'cespare/vim-toml'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/vim-peekaboo'
Plug 'luochen1990/rainbow'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/bufkill.vim'

call plug#end()

" Gui options
colorscheme base16-tomorrow-night
set guifont=DejaVu\ Sans\ Mono:h10
highlight ColorColumn guibg=DarkGray
highlight ColorColumn ctermbg=DarkGray
highlight MatchParen gui=bold cterm=bold ctermbg=NONE guibg=NONE guifg=Magenta ctermfg=Magenta

" Nerd tree options
map <C-n> :NERDTreeToggle<CR>

" Rainbow brackets options
let g:rainbow_active = 1

" Indent-guides options
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" Coc options
autocmd CursorHold * call CocActionAsync('highlight')
command Format :call CocActionAsync('format')
highlight CocHighlightText gui=NONE guibg=#054016 guifg=NONE
inoremap <expr> <c-space> coc#refresh()
nmap <F2> <Plug>(coc-definition)
nmap <leader>fq <Plug>(coc-fix-current)
nmap <leader>rn <Plug>(coc-rename)
nmap [g <Plug>(coc-diagnostic-prev)
nmap ]g <Plug>(coc-diagnostic-next)

" vim-airline options
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1

" Terminal options
" To map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>
" To enter |Terminal-mode| automatically:
autocmd TermOpen * startinsert
command Vcvars :terminal cmd.exe /k "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

" cd to current file
map <leader>cd :cd %:p:h<CR>

set autoindent
set autoread
set clipboard+=unnamedplus
set cmdheight=2
set colorcolumn=80
set copyindent
set cursorline
set directory=~/.vim/swap
set expandtab
set fileencoding=utf-8
set fileencodings=utf8,koi8r,cp1251,cp866,ucs-2le
set fileformat=unix
set hidden
set ignorecase
set incsearch
set infercase
set linebreak
set list
set matchpairs=(:),{:},[:],<:>,"/*":"*/"
set mouse=a
set number
set scrolloff=2
set shiftround
set shiftwidth=4
set showbreak=
set showfulltag
set smartcase
set smartindent
set smarttab
set tabstop=4
set termguicolors
set undodir=~/.vim/undo
set undofile
set undolevels=10000
set updatetime=300
set visualbell
set wildignorecase
set wildmenu

set secure
set noexrc
