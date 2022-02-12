" augroup prevents duplicated autocmds when sourcing
augroup cairo
  autocmd!
  autocmd BufNewFile,BufRead *.cairo set filetype=cairo
augroup END
