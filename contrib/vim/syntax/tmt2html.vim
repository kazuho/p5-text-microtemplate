" Vim syntax file
" Language: tmt
" Maintainer: Kan Fushihara
" Installation:
" To automatilcally load this file when a .mt file is opened, add the
" following lines to ~/.vim/ftdetect/mt.vim:
"
" autocmd! BufReadPost *.mt setfiletype tmt2html
"
" If you want to detect *.html as automatically detect tmt2html or html,
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

