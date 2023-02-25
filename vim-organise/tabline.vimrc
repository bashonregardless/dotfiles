set tabline=

func! Get_tail_of_cwd_of_specified_buffer(n) abort
  return fnamemodify(getcwd(-1, a:n), ':t')
endfunc

set tabline=%!MyTabLine()
" Because we are using tabline to show repo name, we will want it to be always
"+ visible.
set showtabline=2

" Setting tabline ---------------------- {{{ 
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s ..= '%#TabLineSel#'
    else
      let s ..= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s ..= '%' .. (i + 1) .. 'T'

    " the label is made by MyTabLabel()
    let s ..= ' %{MyTabLabel(' .. (i + 1) .. ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s ..= '%#TabLineFill#%T'

 " " right-align the label to close the current tab page
 " if tabpagenr('$') > 1
 "   let s ..= '%=%#TabLine#%999Xclose'
 " endif

   let i = 0
   let s ..= '%= '
   while i < argc()
     let f = fnamemodify(argv(i), ':t')
     if i == argidx()
       let s ..= '%4*' .. f .. '  '
     else
       let s ..= '%2*' .. f .. '  '
     endif
     let i = i + 1
   endwhile

  return s
endfunction

function MyTabLabel(n)
  let s = ''
  "let buflist = tabpagebuflist(a:n)
  "let winnr = tabpagewinnr(a:n)
  let s ..= Get_tail_of_cwd_of_specified_buffer(a:n)
  "let s ..= '  |'
  "return bufname(buflist[winnr - 1])
  return s
endfunction

"* The "%!" expression is evaluated in the context of the
"+ current window and buffer, while %{} items are evaluated in the
"+ context of the window that the statusline belongs to.

"func! Get_head_of_current_file_name() abort
"  return fnamemodify(expand('%'), ':p:.:h').'/'
"endfunc
"func! Get_tail_of_current_file_name() abort
"  return fnamemodify(expand('%'), ':t')
"endfunc
"set tabline+=%2*	" Switch to User1 highlight group
"set tabline+=\ 	" Space
"set tabline+=%<	" Where to truncate line if too long.  Default is at the start. No width fields allowed.
"set tabline+=%{Get_head_of_current_file_name()}
" }}}

""" see vim-todo
""function WincentTablineLabel(n) abort
""  let l:buflist=tabpagebuflist(a:n)
""  let l:winnr=tabpagewinnr(a:n)
""  return pathshorten(fnamemodify(bufname(buflist[winnr - 1]), ':~:.'))
""endfunction
""
""" Cleaner/simpler clone of the built-in tabline, but without the window
""" counts, the modified flag, or the close widget.
""function WincentTablineLine() abort
""  let l:line=''
""  let l:current=tabpagenr()
""  for l:i in range(1, tabpagenr('$'))
""    if l:i == l:current
""      let l:line.='%#TabLineSel#'
""    else
""      let l:line.='%#TabLine#'
""    end
""    let l:line.='%' . i . 'T' " Starts mouse click target region.
""    let l:line.=' %{WincentTablineLabel(' . i . ')} '
""  endfor
""  let l:line.='%#TabLineFill#'
""  let l:line.='%T' " Ends mouse click target region(s).
""  return l:line
""endfunction
""
""set tabline=%!WincentTablineLine()

" NOTE highlight example:
"+ cterm option colors dont work. What works is guibg, guifg, gui
" This won't work
hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
" This works
hi TabLine ctermfg=14 guifg=#C0C0C0 guibg=#484848 gui=bold
" This won't work
hi TabLineSel ctermfg=Red ctermbg=Yellow gui=bold
