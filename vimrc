source ~/repos/dotfiles/vim-organise/plug.vimrc
source ~/repos/dotfiles/vim-organise/general.vimrc
source ~/repos/dotfiles/vim-organise/leader-mappings.vimrc
source ~/repos/dotfiles/vim-organise/statusline.vimrc
source ~/repos/dotfiles/vim-organise/tabline.vimrc
source ~/repos/dotfiles/vim-organise/ale.vimrc
source ~/repos/dotfiles/vim-organise/projectionist.vimrc
source ~/repos/dotfiles/vim-organise/fold.vimrc
source ~/repos/dotfiles/vim-organise/git.vimrc

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

" map save ':w' 
nnoremap <C-S> :w<cr>

" Fzf settings and mappings ---------------------- {{{ 
" Excerpted form textbook 'Modern Vim' Pg24
nnoremap <C-p> :<C-u>FZF<CR>
" Find files using fzf-vim command-line sugar.

" nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>rg <cmd>Rg<cr>
nnoremap <leader>fb <cmd>Buffers<cr>
nnoremap <leader>fh <cmd>History:<cr>
" }}}

" Split navigations ---------------------- {{{ 
nnoremap <C-J> <C-W><C-J>
" TODO NOTE that the below mapping is interfering with LSP mapping
nnoremap <C-K> <C-W><C-K>
"* When netrw is open, the mapping below is overridden by the one in netrw.
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}

" map <Esc> fj ---------------------- {{{ 
nnoremap fj <esc>
vnoremap fj <esc>
onoremap fj <esc>
cnoremap fj <esc>
inoremap fj <esc>
" }}}

" Search and replace ---------------------- {{{ 
" " Word under cursor
" nnoremap <leader>s :%s/\v<<C-r><C-w>>/
" " Alternatively, you could use this mapping so that the final /g is already
" "+ entered:
" "+ :nnoremap <Leader>s :%s/\v<<C-r><C-w>>/g<Left><Left>
"
" "search and replace visually highlighted text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" }}}

" Excerpted from Modern Vim Craft
" Using the Current Neovim Instance as Your Preferred Text Editor
if has('nvim') && executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" Excerpted from book "Modern vim craft", Pg 67
"let test#strategy = "dispatch"

" TODO create a mapping for the below command to blame a particular line
" number in vim in a file
" Git log -L77,77:src/shared/work/work_config.js

" TODO Closing bracket menace when not need. Solve it!"
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

" [Refer: https://learnvimscriptthehardway.stevelosh.com/chapters/08.html]
iab imr import React from 'react'

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

" Delete the contents inside of the last(previous) parentheses and place you in 
"+ insert mode between them.
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap an{ :<c-u>normal! f{va{<cr>
onoremap il{ :<c-u>normal! F{vi{<cr>
onoremap al{ :<c-u>normal! F{va{<cr>


" NOTE The functionality to achieve which this mapping was created for, is
"+ provided by default using the combination `ci"`. This is also true for
"+ single quotes. So, the mapping group below is redundant.
" Also note that it is not the case with braces.
"onoremap in" :<c-u>normal! f"vi"<cr>
"onoremap an" :<c-u>normal! f"va"<cr>
"onoremap il" :<c-u>normal! F"vi"<cr>
"onoremap al" :<c-u>normal! F"va"<cr>


" Navigate arglist
nnoremap ]a :next<CR>
nnoremap ]A :last<CR>
nnoremap [a :prev<CR>
nnoremap [A :first<CR>

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

set guicursor+=a:blinkon1

hi Folded ctermfg=14 ctermbg=242 guifg=#7aa2f7 guibg=#282828

" Navigating HTML tags in Vim
" TODO These mapping fail for self closing tags. Fix it!
"nnoremap [vt vatv
"nnoremap ]vt vatov

" Vim unimpaired plugin provides mapping to toggle hlsearch.
"+ This is good, but what I'd like to have is to keep hlsearch on all the time,
"+ and instead have a mapping to turn off the highlighted matches.
"+ So remapping this unimpaired shortcut
nnoremap ]oh :noh<cr>

" Can I disable continuation of comments to the next line in Vim?
nnoremap [dc :set formatoptions+=cro
nnoremap ]dc :set formatoptions-=cro

