inoremap jj <Esc>

syntax enable
"set background=dark
"colorscheme solarized

set clipboard=unnamedplus

set mouse=a

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

"fix common command typos
:command WQ wq
:command Wq wq
:command W w
:command Q q

map <F5> :setlocal spell! spelllang=en_gb<CR>
nnoremap <F6> "=strftime("%Y-%m-%d")<CR>P
inoremap <F6> <C-R>=strftime("%Y-%m-%d")<CR>
