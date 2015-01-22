colo elflord
map <F5> :setlocal spell! spelllang=en_gb<CR>
nnoremap <F6> "=strftime("%Y-%m-%d")<CR>P
inoremap <F6> <C-R>=strftime("%Y-%m-%d")<CR>

syntax on

"set relativenumber
set number
highlight LineNr ctermfg=yellow ctermbg=black

set list lcs=tab:\|\ 

"map jj to Esc in insert mode
inoremap jj <Esc>
