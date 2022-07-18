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
  call minpac#add('dense-analysis/ale', {'type': 'start'})

  " Autocomplete Plugins ---------------------- {{{
  " Plugins are for lsp completion/autocompletion
  call minpac#add('hrsh7th/cmp-nvim-lsp', {'type': 'start'})
  call minpac#add('hrsh7th/cmp-buffer', {'type': 'start'})
  call minpac#add('hrsh7th/cmp-path', {'type': 'start'})
  call minpac#add('hrsh7th/cmp-cmdline', {'type': 'start'})
  call minpac#add('hrsh7th/nvim-cmp', {'type': 'start'})
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
  \ 'bg_float': "#282828",
\ }
" }}}

set shiftwidth=2
set smartindent

" Excerpted from SO question - How do I deal with vim buffers when switching git branches?
set autoread

set cursorline

"set relative 'hybrid' line numbers
set rnu

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

func! Bufcount() abort
  return len(getbufinfo({'buflisted':1}))
endfunc
set statusline+=%1*	" Switch to User1 highlight group
set statusline+=\ 	" Space
set statusline+=%{Bufcount()}\ 

" Function Get_tail_of_cwd gets only the filename from the path. Verify?
func! Get_tail_of_cwd() abort
  return fnamemodify(getcwd(), ':t')
endfunc
"* The "%!" expression is evaluated in the context of the
"+ current window and buffer, while %{} items are evaluated in the
"+ context of the window that the statusline belongs to.
set statusline+=%3*	" Switch to User3 highlight group 
set statusline+=\ 	" Space
set statusline+=%{Get_tail_of_cwd()}\ 

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

" Current line number
func! Get_current_line_number() abort
  return line(".")
endfunc
set statusline+=%0*	" Switch to User0 highlight group
set statusline+=\ 	" Space
set statusline+=%{Get_current_line_number()}
set statusline+=/

" Total lines number
set statusline+=%0*	" Switch to User0 highlight group
set statusline+=%L


hi User0 guifg=#ffffff  guibg=#0e0e0e
hi User1 guifg=#44730a  guibg=#0e0e0e
hi User2 guifg=#44730a  guibg=#0e0e0e
hi User3 guifg=#6e360a  guibg=#0e0e0e
hi User4 guifg=#7acd12  guibg=#0e0e0e gui=bold
hi User8 guifg=#ffffff  guibg=#0e0e0e

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
" Git, status shortcut
nnoremap <leader>gs :Git status<cr>

" Git, commit shortcut
nnoremap <leader>gc :Git commit -m "[

"Git, checkout shortcut
nnoremap <leader>gh :Git checkout 

" Git, on a conflicted file opens 3-way diff
nnoremap <leader>gp :vert Gdiffsplit!<cr>

" Git, List conflicted files
nnoremap <leader>glc :Git diff --name-only --diff-filter=U<cr>

" Git view log of file added
nnoremap <leader>gfa :Git log --diff-filter=A -- <C-r>%

" Git diff with upstream file
nnoremap <leader>gdu :vert Gdiffsplit origin/
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
let transcarent_path=expandcmd('~/transcarent/')
cnoremap ^^ <C-R>=fnameescape(transcarent_path)<cr>
nnoremap <leader>rew :e <C-R>=fnameescape(transcarent_path)<cr>
nnoremap <leader>res :sp <C-R>=fnameescape(transcarent_path)<cr>
nnoremap <leader>rev :vsp <C-R>=fnameescape(transcarent_path)<cr>
nnoremap <leader>ret :tabe <C-R>=fnameescape(transcarent_path)<cr>
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
let g:user_emmet_leader_key = '-'

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

" Excerpted from book "Modern vim craft", Pg 67
"let test#strategy = "dispatch"

" TODO create a mapping for the below command to blame a particular line
" number in vim in a file
" Git log -L77,77:src/shared/work/work_config.js

" Mapping to run command
"
" TestFile
nnoremap ,tf :TestFile<cr>
let test#neovim#term_position = "vert"

" Automatic closing brackets for Vim
""inoremap " ""<left>
""inoremap ' ''<left>
""inoremap ( ()<left>
""inoremap [ []<left>
""inoremap { {}<left>
""inoremap {<CR> {<CR>}<ESC>O
""inoremap {;<CR> {<CR>};<ESC>O
""inoremap (=<CR> ()<space>=><space>{<CR>}<ESC>O

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

" [Refer: https://learnvimscriptthehardway.stevelosh.com/chapters/15.html]
"+ Operator pending mapping:
"+ Delete the contents inside of the next parentheses and place you in 
"+ insert mode between them.
onoremap in( :<c-u>normal! f(vi(<cr>
" Delete the contents inside of the last(previous) parentheses and place you in 
"+ insert mode between them.
onoremap il( :<c-u>normal! F)vi(<cr>

" Mapping to add current file to arglist
nnoremap <leader>aa :argadd %<cr>

" Mapping to add current file to arglist
nnoremap <leader>ad :argdelete %<cr>

"open child block after matching braces
inoremap <leader>o <esc>i<C-j><esc>ko

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
nnoremap <silent> ]B :blast<CR>
