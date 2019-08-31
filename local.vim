" Common settings
"set mouse=a
"set expandtab
" do not go to a new line
set iskeyword+=_,$,@,%,#,-
" no blink on gvim
set gcr=a:blinkon0
" store viminfo in ~/.cache/vim
"set viminfo+=n$HOME/.cache/vim/viminfo

" Key mappings
nmap <leader>s :call RunSearcher('Rg')<cr>
nmap <leader>g :Ack<space>

vnoremap <silent> gv :call VisualSelection('gv', '')<CR>
" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Advanced settings
" tabstop and shiftwidth is already set to 4, so just consider 8 and 2
" follows linux C coding style (noexpandtab)
autocmd BufNewFile,BufRead *.[ch] set noexpandtab tabstop=8 shiftwidth=8
autocmd BufNewFile,BufRead *.md set expandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.rst set expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType python setlocal textwidth=79 tabstop=4 shiftwidth=4 softtabstop=4 expandtab shiftround autoindent
autocmd BufNewFile *.[ch],*.cpp,*.sh,*.py exec ":call SetTitle('Jason Wang')"

" Misc
" Set the right term parameter when use tmux
if exists('$TMUX')
    set term=screen-256color
endif

" diff mode
if &diff
    set diffopt +=iwhite
    map ] ]c
    map [ [c
    hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
    hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
    hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
endif

" Man viewer
runtime ftplugin/man.viminfo
