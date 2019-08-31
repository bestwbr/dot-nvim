" Functions

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    let l:search_cmd = "Rg"
    if a:direction == 'gv'
        call CmdLine(l:search_cmd . " " . l:pattern)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Intialize dirctories
function! InitializeDirectories()
    let vimdir = $HOME . '/.cache/vim/'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }
    let cachedir = vimdir
    for [dirname, settingname] in items(dir_list)
        let directory = cachedir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction

" Strip traling whitespace
function! StripTrailingWhitespace()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" Run string search command
function! RunSearcher(cmd)
    let l:pattern = expand('<cword>')
    let l:rgcmd = ':' . a:cmd . ' ' . l:pattern
    exec l:rgcmd
endfunction

" The function for setting title
function! SetTitle(author)
    let l:curdate = strftime('%Y')
    let l:copyright = 'Copyright © ' . l:curdate . ' ' . a:author . '. All Rights Reserved.'
    let l:script_env = '#!/usr/bin/env '

    if &filetype == 'sh'
        call setline(1, l:script_env . 'bash')
        call append(line("."), "")
        call append(line(".")+1, "")
    elseif &filetype == 'python'
        call setline(1, l:script_env . 'python3')
        call append(line("."),"")
        call append(line(".")+1, "")
    else
        call setline(1, "/*")
        call append(line("."), ' * ' . l:copyright)
        call append(line(".")+1," */")
        call append(line(".")+2, "")
        call append(line(".")+3, "")
    endif

    if expand("%:e") == 'c'
        call append(line(".")+4, '#include <stdio.h>')
        call append(line(".")+5, "")
        call append(line(".")+6, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+4, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+5, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+6, "")
        call append(line(".")+7, "")
        call append(line(".")+8, "")
        call append(line(".")+9, "#endif")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+4, "#include <iostream>")
        call append(line(".")+5, "using namespace std;")
        call append(line(".")+6, "")
        call append(line(".")+7, "")
    endif
    " move cursor to appreciate line
    let l:line_num = line('$')
    if expand("%:e") == 'h'
        call cursor(l:line_num - 2, 1)
    else
        call cursor(l:line_num, 1)
    endif
endfunction

function! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif   

    return g:cmd_edited
endfunction

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunction
