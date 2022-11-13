" Status line ---------------------- {{{
"* Statuslines is being set incrementally using += operator,
"+ This means the line that comes before the other will also
"+ have the same order in statusline rendering.
" [Refer : https://stackoverflow.com/questions/5375240/a-more-useful-statusline-in-vim]
set statusline=

"func! Bufcount() abort
"  return len(getbufinfo({'buflisted':1}))
"endfunc
"set statusline+=%1*	" Switch to User1 highlight group
"set statusline+=\ 	" Space
"set statusline+=%{Bufcount()}\ 

"" Function Get_tail_of_cwd gets only the filename from the path. Verify?
"func! Get_tail_of_cwd() abort
"  return fnamemodify(getcwd(), ':t')
"endfunc
""* The "%!" expression is evaluated in the context of the
""+ current window and buffer, while %{} items are evaluated in the
""+ context of the window that the statusline belongs to.
"set statusline+=%3*	" Switch to User3 highlight group 
"set statusline+=\ 	" Space
"set statusline+=%{Get_tail_of_cwd()}\ 

"* Comments that begin with '"`' are commands/code
"` set statusline+=%2*\ %<%t\ 
" As a substitute to only the Tail of the file name (last component of the name).
"+ we can use fullpath if we need to track the path to file
func! Get_head_of_current_file_name() abort
  return fnamemodify(expand('%'), ':p:.:h').'/'
endfunc
func! Get_tail_of_current_file_name() abort
  return fnamemodify(expand('%'), ':t')
endfunc
set statusline+=%2*	" Switch to User1 highlight group
set statusline+=\ 	" Space
set statusline+=%<	" Where to truncate line if too long.  Default is at the start. No width fields allowed.
set statusline+=%{Get_head_of_current_file_name()}
set statusline+=%4*
set statusline+=%{Get_tail_of_current_file_name()}
set statusline+=\ 
""set statusline+=%f	" Path to the file in the buffer, as typed or relative to current directory.
""set statusline+=%*	" Restore normal highlight with %* or %0*

set statusline+=%8*	" Switch to User8 highlight group
set statusline+=%<
set statusline+=%m	" Modified flag, text is "[+]"; "[-]" if 'modifiable' is off.

func! Get_alternate_filename() abort
  return fnamemodify(expand('#'), ':t')
endfunc
set statusline+=%1*	" Switch to User1 highlight group
set statusline+=\ 	" Space
set statusline+=%{Get_alternate_filename()}\ 

" See Point 2 in file all-regexp-ever-used in compSc repo
func! Format_fugitive_statusline() abort
  let l:fugitive_statusline = exists('g:loaded_fugitive') ? fugitive#statusline() : ''
  return '⎇.'.' '.substitute(fugitive_statusline, '\v\[.*\((.*)\)\]', '\1', '')
endfunc
set statusline+=%0*	" Switch to User0 highlight group
set statusline+=\ 	" Space
set statusline+=%=	" Separation point between alignment sections. Each section will be separated by an equal number of spaces.
set statusline+=%{Format_fugitive_statusline()}\ 
""set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}\ 

"" Current line number
"func! Get_current_line_number() abort
"  return line(".")
"endfunc
"set statusline+=%0*	" Switch to User0 highlight group
"set statusline+=\ 	" Space
"set statusline+=%{Get_current_line_number()}
"set statusline+=/

" Total lines number
set statusline+=%0*	" Switch to User0 highlight group
set statusline+=%L
set statusline+=\ 

" Add %{ObsessionStatus()} to 'statusline', 'tabline', or 'titlestring' to get
"+ an indicator when Obsession is active or paused.
set statusline+=%{ObsessionStatus()}

" TODO when the space in statusline is limited, prefer name of current file
" and not alternate file"


hi User0 guifg=#ffffff  guibg=#0e0e0e
hi User1 guifg=#44730a  guibg=#0e0e0e
hi User2 guifg=#44730a  guibg=#0e0e0e
hi User3 guifg=#6e360a  guibg=#0e0e0e
hi User4 guifg=#7acd12  guibg=#0e0e0e gui=bold
hi User8 guifg=#ffffff  guibg=#0e0e0e

" }}}
