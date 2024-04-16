call plug#begin()

Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'cespare/vim-toml'
Plug 'chriskempson/base16-vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'junegunn/fzf'
Plug 'ap/vim-css-color'
Plug 'junegunn/vim-peekaboo'
Plug 'luochen1990/rainbow'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/bufkill.vim'
Plug 'pboettch/vim-cmake-syntax'
Plug 'chr4/nginx.vim'
Plug 'nfnty/vim-nftables'

call plug#end()

" Gui options
colorscheme base16-tomorrow-night
set guifont=DejaVu\ Sans\ Mono:h10
highlight ColorColumn guibg=#08004d
highlight MatchParen gui=bold cterm=bold ctermbg=NONE guibg=NONE guifg=Magenta ctermfg=Magenta

" FZF options
nmap <C-p> :FZF<CR>

" vim-fswitch options
" Use F4 key as in QtCreator. (Toggle header and cpp files)
map <F4> :FSHere<CR>

" Rainbow brackets options
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['Red', 'LightGreen', 'Yellow', 'Cyan', 'Orange', 'White'],
\   'separately': {
\       'cmake': 0,
\   }
\}


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
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
let g:coc_filetype_map = {
    \ 'jinja.html': 'html',
    \ }

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
" Use K to show documentation in preview window
nnoremap K :call ShowDocumentation()<CR>


" vim-airline options
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1

" Terminal options
" To map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>
" To enter |Terminal-mode| automatically:
autocmd TermOpen * startinsert
command Vcvars :terminal cmd.exe /k "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
command W :w
command Wa :wa
command Tralling :%s/\s\+$//e

" Move by visual lines rather than actual lines with k,j
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j
nnoremap 0 g0
nnoremap $ g$
nnoremap g0 0
nnoremap g$ $

" Restore cursor position when opening a file
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

autocmd BufWritePre /tmp/* setlocal noundofile

set autoindent
set autoread
set cmdheight=2
set colorcolumn=80
set copyindent
set cursorline
set directory=~/.vim/swap//
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
set undodir=~/.vim/undo//
set undofile
set undolevels=10000
set updatetime=300
set visualbell
set wildignorecase
set wildmenu

set secure
set noexrc
