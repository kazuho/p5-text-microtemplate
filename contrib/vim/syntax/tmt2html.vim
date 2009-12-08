" Vim syntax file
" Language: tmt
" Maintainer: Kan Fushihara
" Installation:
" To automatilcally load this file when a .rhtml file is opened, add the
" following lines to ~/.vim/filetype.vim:
"
" augroup filetypedetect
" au! BufRead,BufNewFile *.tmt setfiletype tmt
" augroup END
"
" You will have to restart vim for this to take effect. In any case it
" is a good idea to read ":he new-filetype" so that you know what is going
" on, and why the above lines work.
 
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif
 
exec "runtime! syntax/html.vim"
unlet! b:current_syntax
 
exec "runtime! syntax/tmt.vim"

