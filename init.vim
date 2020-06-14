call plug#begin()

Plug 'chriskempson/base16-vim'
Plug 'junegunn/vim-peekaboo'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

inoremap <expr> <c-space> coc#refresh()
" Add `:Format` command to format current buffer.
command Format :call CocActionAsync('format')
nmap <F2> <Plug>(coc-definition)

colorscheme base16-tomorrow-night
set guifont=DejaVu\ Sans\ Mono:h10

" To map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>

" To enter |Terminal-mode| automatically:
autocmd TermOpen * startinsert
command Vcvars :terminal cmd.exe /k "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

set autochdir
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
set showbreak=>
set showfulltag
set smartcase
set smartindent
set smarttab
set tabstop=4
set undodir=~/.vim/undo
set undofile
set undolevels=10000
set updatetime=300
set visualbell
set wildignorecase
set wildmenu

highlight ColorColumn guibg=DarkGray

set secure
set exrc
