" Example Code for detect *.html as tmt2html or tt2html or xhtml or html.

function! s:detect_xhtml()
    if getline(1).getline(2).getline(3) =~ '\<!DOCTYPE\s\_.\sXHTML\s'
        setfiletype xhtml
    endif
    setfiletype html
endfunction

function! s:detect_html()
    let save_cursor = getpos('.')
    call cursor(1, 1)
    if search('->', 'cn' ) > 0
        setfiletype tmt2html
    " XXX: if you have tt2html syntax, please uncomment it.
    " elseif search('\[%', 'cn') > 0
    "     setfiletype tt2html
    else
        call s:detect_xhtml()
    endif
    call setpos('.', save_cursor)
endfunction

autocmd! BufReadPost *.html call s:detect_html()

