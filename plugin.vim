if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " colorscheme
  call dein#add('morhetz/gruvbox')
  call dein#add('tomasr/molokai')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " Completion
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('honza/vim-snippets')
  call dein#add('SirVer/ultisnips')
  call dein#add('rip-rip/clang_complete')
  call dein#add('zchee/deoplete-jedi')

  " Git wrap for (neo)vim
  call dein#add('tpope/vim-fugitive')
  call dein#add('/usr/bin/fzf')
  call dein#add('junegunn/fzf.vim')

  " Developping, Coding, Writing
  call dein#add('w0rp/ale')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('raimondi/delimitmate')
  call dein#add('scrooloose/syntastic')

  " Language support
  call dein#add('klen/python-mode')
  call dein#add('rust-lang/rust.vim')
  call dein#add('derekwyatt/vim-scala')
  call dein#add('suan/vim-instant-markdown')
  call dein#add('lervag/vimtex')
  call dein#add('vhda/verilog_systemverilog.vim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

"colorscheme gruvbox
colorscheme molokai
let g:airline#extensions#tabline#enabled = 1

let g:deoplete#enable_at_startup = 1

let g:neosnippet#snippets_directory='~/.cache/dein/repos/github.com/honza/vim-snippets/snippets' 
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:clang_library_path='/usr/lib/libclang.so.8'
let g:clang_snippets = 1
let g:clang_snippets_engine = 'ultisnips'
