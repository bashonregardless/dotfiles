" [Refer: https://learnvimscriptthehardway.stevelosh.com/chapters/18.html]
"+ Set up folding for Vimscript files
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" TODO
"function! IndentLevel(lnum)
"    return indent(a:lnum) / &shiftwidth
"endfunction
"function! NextNonBlankLine(lnum)
"    let numlines = line('$')
"    let current = a:lnum + 1
"
"    while current <= numlines
"        if getline(current) =~? '\v\S'
"            return current
"        endif
"
"        let current += 1
"    endwhile
"
"    return -2
"endfunction
"function! GetPotionFold(lnum)
"    if getline(a:lnum) =~? '\v^\s*$'
"        return '-1'
"    endif
"
"    let this_indent = IndentLevel(a:lnum)
"    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))
"
"    if next_indent == this_indent
"        return this_indent
"    elseif next_indent < this_indent
"        return this_indent
"    elseif next_indent > this_indent
"        return '>' . next_indent
"    endif
"endfunction
"
"set foldexpr=GetPotionFold(v:lnum)

set foldlevelstart=1
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
""set nofoldenable

" Fold shortcuts
nnoremap z{ zfa{ 
nnoremap z( zfa( 

