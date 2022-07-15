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
  " Removing fzf as part of fzf because we also need to 
  " source fzf completion script from bash_profile,
  " which can come only after fzf is cloned. (not necessarily, but installed
  " too)
  " call minpac#add('junegunn/fzf', {'type': 'start'})
  call minpac#add('mhinz/neovim-remote', {'type': 'start'})
  call minpac#add('neovim/nvim-lspconfig', {'type': 'start'})
  call minpac#add('nvim-treesitter/nvim-treesitter', {'type': 'start'})
  "call minpac#add('nvim-lua/plenary.nvim', {'type': 'start'})
  " call minpac#add('nvim-telescope/telescope.nvim', {'type': 'start'})
  "call minpac#add('nvim-telescope/telescope-fzf-native.nvim', {'type': 'start'})
  call minpac#add('tpope/vim-fugitive', {'type': 'start'})
  call minpac#add('tpope/vim-surround', {'type': 'start'})
  call minpac#add('tpope/vim-obsession', {'type': 'start'})
  call minpac#add('folke/tokyonight.nvim', {'type': 'start'})
  call minpac#add('mattn/emmet-vim', {'type': 'start'})
  call minpac#add('tpope/vim-projectionist', {'type': 'start'})
  call minpac#add('vim-test/vim-test', {'type': 'start'})
  call minpac#add('dense-analysis/ale', {'type': 'start'})

  " The next 5 Plugin are for lsp completion/autocompletion
  call minpac#add('hrsh7th/cmp-nvim-lsp', {'type': 'start'})
  call minpac#add('hrsh7th/cmp-buffer', {'type': 'start'})
  call minpac#add('hrsh7th/cmp-path', {'type': 'start'})
  call minpac#add('hrsh7th/cmp-cmdline', {'type': 'start'})
  call minpac#add('hrsh7th/nvim-cmp', {'type': 'start'})
  " call minpac#add('vim-airline/vim-airline')

  " In ex-mode call 
  " PluginUpdate		- to update plugin usgin minpac
  " PluginClean		- to clean plugin usgin minpac
  command! PackUpdate call minpac#update()
  command! PackClean call minpac#clean()
endif

" NOTE that the below configs are for both vim and neovim

" set syntax off (a regexp based syntax highlighter and let 
" tree sitter handle highlighting.
" NOTE that this option does not necessarily affect tree-sitter
" syntax highlighting. 
" syntax=off
let g:tokyonight_style = "night"
colorscheme tokyonight

set shiftwidth=2
set smartindent

" Excerpted from SO question - How do I deal with vim buffers when switching git branches?
set autoread

"set cursorline
set cursorline

" map save ':w' 
nnoremap <C-S> :w<cr>

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

" Function Stl_filename gets only the filename from the path. Verify?
func! Get_tail_of_cwd() abort
  return fnamemodify(getcwd(), ':t')
endfunc
" read :h 'statusline', see usage of {%
"* NOTE that the "%!" expression is evaluated in the context of the
"+ current window and buffer, while %{} items are evaluated in the
"+ context of the window that the statusline belongs to.
set statusline+=%3*	" Switch to User3 highlight group 
set statusline+=\ 	" Space
set statusline+=%{Get_tail_of_cwd()}\ 

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

hi User0 guifg=#ffffff  guibg=#0e0e0e
hi User1 guifg=#44730a  guibg=#0e0e0e
hi User2 guifg=#44730a  guibg=#0e0e0e
hi User3 guifg=#6e360a  guibg=#0e0e0e
hi User4 guifg=#7acd12  guibg=#0e0e0e gui=bold
hi User8 guifg=#ffffff  guibg=#0e0e0e

"Define map leader
let mapleader = ","

" Don't Throw Away the Reverse Character Search Command
" REFER Practical Vim Textbook
noremap \ ,

" Git, on a conflicted file opens 3-way diff
nnoremap <leader>gisp :vert Gdiffsplit!<cr>

" Git, List conflicted files
nnoremap <leader>gilc :Git diff --name-only --diff-filter=U<cr>

" Git, status shortcut
nnoremap <leader>gis :Git status<cr>

" Git, commit shortcut
nnoremap <leader>gic :Git commit -m "[

"Git, checkout shortcut
nnoremap <leader>gih :Git checkout 

"Git, switch shortcut
nnoremap <leader>giw :Git switch - 

" Git view log of file added
nnoremap <leader>gifa :Git log --diff-filter=A -- <C-r>%

" Git diff with upstream file
nnoremap <leader>gidu :vert Gdiffsplit origin/

" Mapping to add current file to arglist
nnoremap <leader>aa :argadd %<cr>

" Mapping to add current file to arglist
nnoremap <leader>ad :argdelete %<cr>

"split navigations
nnoremap <C-J> <C-W><C-J>
" TODO NOTE that the below mapping is interfering with LSP mapping
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"open child block after matching braces
inoremap <leader>o <esc>i<C-j><esc>ko

"open a new line at the top of file entering insert mode
nnoremap <leader>to <esc>ggi<C-j><esc>ki

" Explode split to full size
nnoremap <leader>ee <C-w>_<CR><C-w>\|<CR>
" Escape from full  size
nnoremap <leader>E <C-w>=

" Navigate arglist
nnoremap ]a :next<CR>
nnoremap ]A :last<CR>
nnoremap [a :prev<CR>
nnoremap [A :first<CR>

"set relative 'hybrid' line numbers
:set nu

"map <Esc>
nnoremap fj <esc>
vnoremap fj <esc>
onoremap fj <esc>
cnoremap fj <esc>
inoremap fj <esc>

"Search and replace word under cursor
nnoremap <leader>s :%s/\v<<C-r><C-w>>/
"Alternatively, you could use this mapping so that the final /g is already
"entered:
":nnoremap <Leader>s :%s/\v<<C-r><C-w>>/g<Left><Left>

"search and replace visually highlighted text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" indent file
nnoremap <leader>ai gg=G<C-O>

" delete all trailing whitespace from each line, then replace three 
" or more consecutive line endings with two line endings (a single blank line)
nnoremap <leader>df :%s/\s\+$//e<cr> :%s/\n\{3,}/\r\r/e<cr>

" (REFER: Stackoverflow bookmarked: How to map CAPS LOCK key in VIM?)
" The first line maps escape to the caps lock key when you enter Vim, and the
" second line returns normal functionality to caps lock when you quit.
" This requires Linux with the xorg-xmodmap package installed.
"au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Control'
"au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" (Refer Practical Vim Pg83)
" Traverse the buffer list using four commands— :bprev and :bnext to move
" backward and forward one at a time, and :bfirst and :blast to jump to the
" start or end of the list
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" TODO Similar mappings to navigate arglist


" (Refer Practical Vim Pg101 Link to Vimcasts episode)
" Easy expansion of active file directory
"`nnoremap <leader>ew :e <C-R>=expand('%:p:h').'/'<CR>`
" (Refer Practical Vim Pg101 Link to Vimcasts episode)
" Easy expansion of active file directory in horizontal split
"`nnoremap <leader>es :sp <C-R>=expand('%:p:h').'/'<CR>`
" Easy expansion of active file directory in vertical split
"`nnoremap <leader>ev :vsp <C-R>=expand('%:p:h').'/'<CR>`
" Easy expansion of active file directory in new tab
"`nnoremap <leader>et :tabe <C-R>=expand('%:p:h').'/'<CR>`
" TODO Delete the above commented out para after you have understood
" the concept of %, :p, and :h

" (Refer Practical Vim Pg101)
" Easy expansion of the shell directory(or, in some cases also called
" source directory).
" NOTE: this mapping can also done just like the mapping
" expansion of active file directory
" `cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'`
" TODO Undestand the difference between the above mapping and the one
" below.
" less horrible way of creating the same mappings:
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
" Additionally, this allows you to expand the directory of the current file
" anywhere at the command line by pressing %%

let hrpath=expandcmd('~/hr/')
cnoremap ^^ <C-R>=fnameescape(hrpath)<cr>
map <leader>ew :e ^^
map <leader>es :sp ^^
map <leader>ev :vsp ^^
map <leader>et :tabe ^^

" Make a word SHOUT (uppercase) in insert mode 
inoremap <leader>ws <esc>gUawea

" Fold
nnoremap z{ zfa{ 
nnoremap z( zfa( 

" Excerpted form textbook 'Modern Vim' Pg24
nnoremap <C-p> :<C-u>FZF<CR>

" Excerpted from ALE docs on github, section ' How can I use ALE and coc.nvim
" together?'
""let g:ale_disable_lsp = 1

" [Refer: https://github.com/dense-analysis/ale#2ii-fixing]
" TODO : note that the 'ale_fixers' variable below is global.
"+ You have to make it specific for filetype.
let g:ale_fixers = ['prettier', 'eslint']

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

let g:ale_fix_on_save = 1

" Excerpted from https://github.com/dense-analysis/ale/blob/master/doc/ale-typescript.txt
" , section on tslint
"let g:ale_linters_ignore = {'typescript': ['tslint']}

" Excerpted from https://github.com/dense-analysis/ale/blob/master/doc/ale-typescript.txt
" , section on tsserver
"let g:ale_typescript_tsserver_use_global=1

" Find files using Telescope command-line sugar.
" Excerpted from telescope github page
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Terminal in vertical split mapping
nnoremap <leader>t :vsplit \| terminal<cr>

" Excerpted from Modern Vim Craft
" Using the Current Neovim Instance as Your Preferred Text Editor
if has('nvim') && executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

if has('nvim')
" Terminal insert mode exit
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>

  " Excerpted from text Modern Vim Craft
  " highlight! link TermCursor Cursor
  " highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15

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
  tnoremap <expr> <leader>cp '<C-\><C-N>"'.nr2char(getchar()).'pi'

endif

" REFER :help emmet-customize-key-mappings 
" This might not necessarily be a good mapping, since <leader>=','
" TODO This is indeed causing problem with mappings in emmet vim, see more examples
" in github doc
let g:user_emmet_leader_key = ','

" See Greg Hurrell vim screencast video on youtube
let g:projectionist_heuristics = {
      \"*": {
	\"*.js": {
	  \"alternate": [
	    \"{}.spec.js",
	    \"{}.scss"
	    \],
	    \"type": "source"
	    \},
	    \"*.spec.js": {
	      \  "alternate": [
		\"{}.scss",
		\"{}.js"
	      \],
	      \  "type": "test"
	      \  },
	      \"*.scss": {
	      \  "alternate": [
		\"{}.js",
		\"{}.test.js"
	      \],
		\  "type": "style"
		\}
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

