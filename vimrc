" [Refer: https://learnvimscriptthehardway.stevelosh.com/chapters/18.html]
"+ Set up folding for Vimscript files
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" minpac ---------------------- {{{ 
" Excerpted from minpac doc on github
set packpath^=~/.config/nvim
" Try to load minpac.
packadd minpac

if !exists('g:loaded_minpac')
  " minpac is not available.

  " Settings for plugin-less environment.
else
  " minpac is available.
  call minpac#init()
  " Excerpted from book 'Modern Vim Craft' by Drew Neil
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " [Refer vim-docs, point 1]
  "+ call minpac#add('junegunn/fzf', {'type': 'start'})

  call minpac#add('mhinz/neovim-remote', {'type': 'start'})
  call minpac#add('neovim/nvim-lspconfig', {'type': 'start'})
  call minpac#add('nvim-treesitter/nvim-treesitter', {'type': 'start'})
  call minpac#add('tpope/vim-fugitive', {'type': 'start'})
  call minpac#add('tpope/vim-surround', {'type': 'start'})
  call minpac#add('tpope/vim-obsession', {'type': 'start'})
  call minpac#add('folke/tokyonight.nvim', {'type': 'start'})
  call minpac#add('mattn/emmet-vim', {'type': 'start'})
  call minpac#add('tpope/vim-projectionist', {'type': 'start'})
  call minpac#add('vim-test/vim-test', {'type': 'start'})
  ""call minpac#add('dense-analysis/ale', {'type': 'start'})

  " Autocomplete Plugins ---------------------- {{{
  " Plugins are for lsp completion/autocompletion
 "" call minpac#add('hrsh7th/cmp-nvim-lsp', {'type': 'start'})
 "" call minpac#add('hrsh7th/cmp-buffer', {'type': 'start'})
 "" call minpac#add('hrsh7th/cmp-path', {'type': 'start'})
 "" call minpac#add('hrsh7th/cmp-cmdline', {'type': 'start'})
 "" call minpac#add('hrsh7th/nvim-cmp', {'type': 'start'})
 "" call minpac#add('hrsh7th/cmp-vsnip', {'type': 'start'})
 "" call minpac#add('hrsh7th/vim-vsnip', {'type': 'start'})
  " }}}


  " In ex-mode call 
  "+ PluginUpdate	- to update plugin usgin minpac
  "+ PluginClean		- to clean plugin usgin minpac
  command! PackUpdate call minpac#update()
  command! PackClean call minpac#clean()
endif
" }}}

" NOTE that the below configs are for both vim and neovim

" [Refer vim-docs, point 2] 
"+ syntax=off

" Tokyonight colorscheme settings---------------------- {{{ 
let g:tokyonight_style = "night"
colorscheme tokyonight
let g:tokyonight_colors = {
  \ 'comment': '#A9A9A9',
\ }
" }}}

" TODO The autocmd below should change the colorscheme on the active buffers
"+ to make it more obvious
"augroup change_color_scheme_on_buf_focus_change
"    autocmd!
"    autocmd BufLeave * let b:tokyonight_style = "storm" | :colorscheme tokyonight
"    autocmd BufEnter * let b:tokyonight_style = "night" | :colorscheme tokyonight
"augroup END

set shiftwidth=2
set smartindent

" Excerpted from SO question - How do I deal with vim buffers when switching git branches?
set autoread

set cursorline

"set relative 'hybrid' line numbers
set nu
set rnu

" Excerpted from [Refer : https://jeffkreeftmeijer.com/vim-number/]
" Relative line numbers are helpful when moving around in normal mode, but absolute 
"+ line numbers are more suited for insert mode. When the buffer doesn’t have focus,
"+ it’d also be more useful to show absolute line numbers. For example, when running
"+ tests from a separate terminal split, it’d make more sense to be able to see which
"+ test is on which absolute line number.
" TODO On leaving insert mode by pressing <c-c>, the below command does not
"+ toggle properly. Fix it!
"+ It does work on leaving insert mode with 'fj'.
"+ A. CTRL-C: Quit insert mode, go back to Normal mode. Do not check for abbreviations.
"+ Does not trigger the InsertLeave autocommand event. 
"+ STOP using <C-c>, instead use <C-[> to leave insert mode.
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

"Define map leader
let mapleader = ","

" REFER Practical Vim Textbook
"+ Don't Throw Away the Reverse Character Search Command
noremap \ ,

" map save ':w' 
nnoremap <C-S> :w<cr>

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

set tabline=

func! Get_tail_of_cwd_of_specified_buffer(n) abort
  return fnamemodify(getcwd(-1, a:n), ':t')
endfunc
"* The "%!" expression is evaluated in the context of the
"+ current window and buffer, while %{} items are evaluated in the
"+ context of the window that the statusline belongs to.
set tabline+=%3*	" Switch to User3 highlight group 
set tabline+=\ 	" Space
set tabline+=%{Get_tail_of_cwd()}\ 

set tabline=%!MyTabLine()


" Setting tabline ---------------------- {{{ 
function MyTabLine()
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

  return s
endfunction

function MyTabLabel(n)
  let s = ''
  "let buflist = tabpagebuflist(a:n)
  "let winnr = tabpagewinnr(a:n)
  let s ..= Get_tail_of_cwd_of_specified_buffer(a:n)
  "return bufname(buflist[winnr - 1])
  return s
endfunction

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


" Fzf settings and mappings ---------------------- {{{ 
" Excerpted form textbook 'Modern Vim' Pg24
nnoremap <C-p> :<C-u>FZF<CR>
" Find files using fzf-vim command-line sugar.
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>rg <cmd>Rg<cr>
nnoremap <leader>fb <cmd>Buffers<cr>
nnoremap <leader>fh <cmd>History:<cr>
" }}}

" Git mappings ---------------------- {{{ 
" Bring up Git in command mode
nnoremap <leader>gg :Git 

" Git, status shortcut
nnoremap <leader>gs :Git status<cr>

" Git, commit shortcut
nnoremap <leader>gc :Git commit -m "[

"Git, checkout shortcut
nnoremap <leader>gh :Git checkout 

"Git, switch shortcut
nnoremap <leader>gw :Git switch -<cr>

" Git, on a conflicted file opens 3-way diff
nnoremap <leader>gp :vert Gdiffsplit!<cr>

" Git, List conflicted files
nnoremap <leader>glc :Git diff --name-only --diff-filter=U<cr>

" Git view log of file added
nnoremap <leader>gfa :Git log --diff-filter=A -- <C-r>%

" Git diff with upstream file
nnoremap <leader>gdu :vert Gdiffsplit origin/

" Git log to get commits only for a specific branch
nnoremap <leader>gcl :Git cherry -v [ develop ] [ mybranch ]
" This would show all of the commits which are contained within mybranch, 
"+ but NOT in develop. If you leave off the last option (mybranch),
"+ it will compare the current branch instead.

" View the change history of a file 
nnoremap <leader>gfh :Git log -p -- [filename]

" How to create a local branch from an existing remote branch?
nnoremap <leader>gco :Git checkout -b [new_branch_name] [remote_name]/[remote_branch_name]
" }}}

" Split navigations ---------------------- {{{ 
nnoremap <C-J> <C-W><C-J>
" TODO NOTE that the below mapping is interfering with LSP mapping
nnoremap <C-K> <C-W><C-K>
"* When netrw is open, the mapping below is overridden by the one in netrw.
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}

" Split resize ---------------------- {{{ 
" Explode split to full size
nnoremap <leader>ee <C-w>_<CR><C-w>\|<CR>
" Escape from full size
nnoremap <leader>E <C-w>=
" }}}

" map <Esc> fj ---------------------- {{{ 
nnoremap fj <esc>
vnoremap fj <esc>
onoremap fj <esc>
cnoremap fj <esc>
inoremap fj <esc>
" }}}

" Search and replace ---------------------- {{{ 
" Word under cursor
nnoremap <leader>s :%s/\v<<C-r><C-w>>/
" Alternatively, you could use this mapping so that the final /g is already
"+ entered:
"+ :nnoremap <Leader>s :%s/\v<<C-r><C-w>>/g<Left><Left>

"search and replace visually highlighted text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" }}}

" Directory expansion ---------------------- {{{ 
" (Refer Practical Vim Pg101)
"+ Easy expansion of the shell directory(or, in some cases also called
"+ source directory), repo dir, directory of the current file.

" Expand the directory of the current file anywhere at the command line by pressing %%
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
" This mapping can also be done just like the mapping
"+ expansion of active file directory
"+` cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Expansions of active file directory
nnoremap <leader>ew :e <C-R>=fnameescape(expand('%:h')).'/'<cr>
nnoremap <leader>es :sp <C-R>=fnameescape(expand('%:h')).'/'<cr>
nnoremap <leader>ev :vsp <C-R>=fnameescape(expand('%:h')).'/'<cr>
nnoremap <leader>et :tabe <C-R>=fnameescape(expand('%:h')).'/'<cr>

" Expansions of transcarent directory by pressing ^^.
"+ This helps to change current directory.
"+ All the search will now be performed relative to the changed directory.
let transcarent_path=expandcmd('~/Developer/transcarent/')
cnoremap ^^ <C-R>=fnameescape(transcarent_path)<cr>
nnoremap <leader>rew :e <C-R>=fnameescape(transcarent_path)<cr>
nnoremap <leader>res :sp <C-R>=fnameescape(transcarent_path)<cr>
nnoremap <leader>rev :vsp <C-R>=fnameescape(transcarent_path)<cr>
" TODO Change the below mapping so that user is proompted for the path name
"+ once, and remove the hardcoded value, or make a different mappping for
"+ transcarent path.
nnoremap <leader>ret :tabe <C-R>=fnameescape(transcarent_path)<cr> \| :tcd <C-R>=fnameescape(transcarent_path)<cr>
" }}}

" Fold shortcuts
nnoremap z{ zfa{ 
nnoremap z( zfa( 

" ALE settings ---------------------- {{{ 
" Excerpted from ALE docs on github, section ' How can I use ALE and coc.nvim
"+ together?'
"` let g:ale_disable_lsp = 1

" [Refer: https://github.com/dense-analysis/ale#2ii-fixing]
" TODO : note that the 'ale_fixers' variable below is global.
"+ You have to make it specific for filetype.
let g:ale_fixers = ['prettier', 'eslint']

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

let g:ale_fix_on_save = 1
" }}}

" Excerpted from Modern Vim Craft
" Using the Current Neovim Instance as Your Preferred Text Editor
if has('nvim') && executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" Rename a buffer keeping alternate filename
nnoremap <leader>rn :keepalt file 

" Terminal settings and mapping ---------------------- {{{ 
" Terminal in vertical split mapping
nnoremap <leader>t :vsplit \| terminal<cr>

if has('nvim')
" Terminal insert mode exit
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>

" switch buffers in terminal mode
  tnoremap <M-h> <c-\><c-n><c-w>h
  tnoremap <M-j> <c-\><c-n><c-w>j
  tnoremap <M-k> <c-\><c-n><c-w>k
  tnoremap <M-l> <c-\><c-n><c-w>l

  " Excerpted from http://vimcasts.org/episodes/neovim-terminal-paste/
  " Terminal mode cursor color
  hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE
  hi! TermCursor ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

  " Excerpted from http://vimcasts.org/episodes/neovim-terminal-paste/
  " Pasting in Terminal Mode
  " TODO Not working
  tnoremap <expr> <leader>cp '<C-\><C-N>"'.nr2char(getchar()).'pi'

endif
" }}}

" REFER :help emmet-customize-key-mappings 
" This might not necessarily be a good mapping, since <leader>=','
" TODO This is indeed causing problem with mappings in emmet vim, see more examples
" in github doc
"let g:user_emmet_leader_key = '-'

" See Greg Hurrell vim screencast video on youtube
     let g:projectionist_heuristics = {
	   \"*": {
	     \"*.tsx": {
	       \"alternate": [
		 \"{}.test.tsx",
		 \],
		 \"type": "source"
		 \},
		 \"*.test.tsx": {
		   \  "alternate": [
		     \"{}.tsx"
		     \],
		     \  "type": "test"
		     \  },
		     \}
		     \}

" Close quickfix window mapping
nnoremap <leader>c :cclose<cr>

" TODO paste the copied text at last ponint of insertion
"nnoremap <leader>pi gi<C-R>

" Excerpted from book "Modern vim craft", Pg 67
"let test#strategy = "dispatch"

" TODO create a mapping for the below command to blame a particular line
" number in vim in a file
" Git log -L77,77:src/shared/work/work_config.js

" Mapping to run command
"
" TestFile
nnoremap <leader>tf :TestFile<cr>
let test#neovim#term_position = "vert"

" Automatic closing brackets for Vim
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap (=<CR> ()<space>=><space>{<CR>}<ESC>O

" Comment // mapping

" Sort a list of files by last field. Field seperator '\'
" SOLUTION: The idea is join the last field(column) of each line at the beginning of each of the lines (with a different delimiter, in this case I am using pipe "|")
"
" Then sort on 1st field with pipe ("|") delimited.
"
" Then sort on 1st field with pipe ("|") delimited.
"
" !awk 'BEGIN {FS="/"; OFS="|"}{print $NF,$0}' /Users/harsha/hr-non-repo-tasks/git_rebase_vs_cherry_pick/git_pull_rebase_origin_master_conflict_filenames.js | sort -t"|" -k1 | awk -F "|" '{print $2}'

" [Refer : https://learnvimscriptthehardway.stevelosh.com/chapters/07.html]
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" [Refer: https://learnvimscriptthehardway.stevelosh.com/chapters/08.html]
iab imr -- import React from 'react'

iab foco " ---------------------- {{{
" TODO When "Automatic closing brackets for Vim" mapping is on, an additional
"+ closing bracket is created. Fix it!
"iab ref [Refer: ]

" [Refer: https://learnvimscriptthehardway.stevelosh.com/chapters/15.html]
"+ Operator pending mapping:
"+ Delete the contents inside of the next parentheses and place you in 
"+ insert mode between them.
" TODO if the bracket is already empty something strange happens. Fix it.
"+ If the next Brackets contain text, then that text is deleted and user
"+ is put in insertion mode, else the similar bracker parent bracket is
"+ affected.
"+ Test on file nested-comments.js
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap il( :<c-u>normal! F(vi(<cr>
onoremap al( :<c-u>normal! F(va(<cr>
" Delete the contents inside of the last(previous) parentheses and place you in 
"+ insert mode between them.
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap an[ :<c-u>normal! f[va[<cr>
onoremap il[ :<c-u>normal! F[vi[<cr>
onoremap al[ :<c-u>normal! F[va[<cr>

onoremap in" :<c-u>normal! f"vi"<cr>
onoremap an" :<c-u>normal! f"va"<cr>
onoremap il" :<c-u>normal! F"vi"<cr>
onoremap al" :<c-u>normal! F"va"<cr>

" open child block after matching braces
nnoremap <leader>on{ f{a<c-j><esc>O
nnoremap <leader>on( f(a<c-j><esc>O
nnoremap <leader>ol{ F{a<c-j><esc>O
nnoremap <leader>ol( F(a<c-j><esc>O
"open child block after matching braces
inoremap <leader>o <esc>i<C-j><esc>ko


" Mapping to add current file to arglist
nnoremap <leader>aa :argadd %<cr>

" Mapping to add current file to arglist
nnoremap <leader>ad :argdelete %<cr>

" Navigate arglist
nnoremap ]a :next<CR>
nnoremap ]A :last<CR>
nnoremap [a :prev<CR>
nnoremap [A :first<CR>

" indent file
nnoremap <leader>ai gg=G<C-O>

" (Refer Practical Vim Pg83)
"+ Traverse the buffer list 
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>


" Try ":help [[" and search for "map" in that text.
" In visual line mode [[ not working correctly.
:nnoremap [[ ?{<CR>w99[{
:nnoremap ][ /}<CR>b99]}
:nnoremap ]] j0[[%/{<CR>
:nnoremap [] k$][%?}<CR>

augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=700})
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
hi TabLine ctermfg=14 guifg=Gray guibg=Black
" This won't work
hi TabLineSel ctermfg=Red ctermbg=Yellow

"''set tabline=%!MyTabLine()  " custom tab pages line
"function! MyTabLine()
"  let s = ''
"  " loop through each tab page
"  for i in range(tabpagenr('$'))
"    if i + 1 == tabpagenr()
"      let s .= '%#TabLineSel#'
"    else
"      let s .= '%#TabLine#'
"    endif
"    if i + 1 == tabpagenr()
"      lgrep s .= '%#TabLineSel#' " WildMenu
"    else
"      let s .= '%#Title#'
"    endif
"    " set the tab page number (for mouse clicks)
"    let s .= '%' . (i + 1) . 'T '
"    " set page number string
"    let s .= i + 1 . ''
"    " get buffer names and statuses
"    let n = ''  " temp str for buf names
"    let m = 0   " &modified counter
"    let buflist = tabpagebuflist(i + 1)
"    " loop through each buffer in a tab
"    for b in buflist
"      if getbufvar(b, "&buftype") == 'help'
"        " let n .= '[H]' . fnamemodify(bufname(b), ':t:s/.txt$//')
"      elseif getbufvar(b, "&buftype") == 'quickfix'
"        " let n .= '[Q]'
"      elseif getbufvar(b, "&modifiable")
"        let n .= fnamemodify(bufname(b), ':t') . ', ' " pathshorten(bufname(b))
"      endif
"      if getbufvar(b, "&modified")
"        let m += 1
"      endif
"    endfor
"    " let n .= fnamemodify(bufname(buflist[tabpagewinnr(i + 1) - 1]), ':t')
"    let n = substitute(n, ', $', '', '')
"    " add modified label
"    if m > 0
"      let s .= '+'
"      " let s .= '[' . m . '+]'
"    endif
"    if i + 1 == tabpagenr()
"      let s .= ' %#TabLineSel#'
"    else
"      let s .= ' %#TabLine#'
"    endif
"    " add buffer names
"    if n == ''
"      let s.= '[New]'
"    else
"      let s .= n
"    endif
"    " switch to no underlining and add final space
"    let s .= ' '
"  endfor
"  let s .= '%#TabLineFill#%T'
"  " right-aligned close button
"  " if tabpagenr('$') > 1
"  "   let s .= '%=%#TabLineFill#%999Xclose'
"  " endif
"  return s
"endfunction

