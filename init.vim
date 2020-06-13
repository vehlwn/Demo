call plug#begin()

Plug 'chriskempson/base16-vim'
Plug 'junegunn/vim-peekaboo'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'

call plug#end()

inoremap <expr> <c-space> coc#refresh()
command! -nargs=0 Format :call CocActionAsync('format')
nmap <F2> <Plug>(coc-definition)

colorscheme base16-tomorrow-night
set guifont=DejaVu\ Sans\ Mono:h11

" To map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>

let &shell='cmd.exe /k C:/Users/vehlwn/vim-shell.bat'

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
