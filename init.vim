if 1                                                                                                                                                                     
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/function.vim'
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/plugin.vim'
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config.vim'
try
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/local.vim'
catch
endtry
endif
