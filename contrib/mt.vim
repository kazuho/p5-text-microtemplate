" Vim syntax file
" Language: mt
" Maintainer: Kan Fushihara
" Installation:
" To automatilcally load this file when a .mt file is opened, add the
" following lines to ~/.vim/filetype.vim:
"
" augroup filetypedetect
" au! BufRead,BufNewFile *.mt setfiletype mt
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
"Put the perl syntax file in @perlTop
syn include @perlTop syntax/perl.vim
 
syn cluster mtRegions contains=mtOneLiner,mtBlock,mtExpression
 
syn region mtOneLiner matchgroup=mtDelim start=#^[%?]?\@!# end=#$# keepend contains=@perlTop containedin=ALLBUT,@mtRegions keepend oneline
syn region mtBlock matchgroup=mtDelim start=#<[%?]?\?# end=#[%|?]?># keepend contains=@perlTop containedin=ALLBUT,@mtRegions keepend
syn region mtExpression matchgroup=mtDelim start=#<[%|?]?=\?# end=#[%|?]?># keepend contains=@perlTop containedin=ALLBUT,@mtRegions keepend
 
hi def link mtDelim todo
 
let b:current_syntax = 'mt'
