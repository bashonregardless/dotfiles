"Define map leader
let mapleader = ","

" REFER Practical Vim Textbook
"+ Don't Throw Away the Reverse Character Search Command
noremap \ ,

" Split resize ---------------------- {{{ 
" Explode split to full size
nnoremap <leader>ee <C-w>_<CR><C-w>\|<CR>
" Escape from full size
nnoremap <leader>E <C-w>=
" }}}

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

" indent file
nnoremap <leader>ai gg=G<C-O>

" Javascript copy entire funciton with declaration
"+ The below mapping should be run from within the function body
" TODO This mapping is filetype specific. Move it to ftp.
" TODO Warning Suffix of this mapping (`<leader>c`) already used in another mapping. This is
" causing delay in execution of that mapping. Find a solution.
nnoremap <leader>cf [mV%y

" Hard mdoe
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
augroup hardmodeInsertModeToggle
  autocmd!
  autocmd InsertLeave * call HardMode()
  autocmd InsertEnter * call EasyMode()
augroup END

" ALE Navigation
nnoremap <leader>an :ALENext<cr>
nnoremap <leader>ap :ALEPrevious<cr>

"Recursively open all folds in current open fold?
"+ [Refer: https://vi.stackexchange.com/a/16046/26997]
nnoremap <leader>O zczA

" How to delete line above/below cursor, but not current line?
nnoremap <leader>[d :-d<cr>
nnoremap <leader>]d :+d<cr>

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

" Rename a buffer keeping alternate filename
nnoremap <leader>rn :keepalt file 

" Terminal settings and mapping ---------------------- {{{ 
" Terminal in vertical split mapping
nnoremap <leader>t :vsplit \| terminal<cr>
" TODO Create a mapping to open termial and cd into the cwd or repo dir
"+ nnoremap <leader>t :vsplit \| terminal<cr>

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
let g:user_emmet_leader_key='<C-y>'

" Close quickfix window mapping
nnoremap <leader>c :cclose<cr>

" TODO paste the copied text at last ponint of insertion
"nnoremap <leader>pi gi<C-R>

" Mapping to run command
"
" TestFile
nnoremap <leader>tf :TestFile<cr>
let test#neovim#term_position = "vert"

" [Refer : https://learnvimscriptthehardway.stevelosh.com/chapters/07.html]
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>n :NERDTreeFocus<CR>
" Override warning. Overrides a native feature.
nnoremap <C-n> :NERDTree<CR>
" Override warning. Overrides a native feature.
nnoremap <C-t> :NERDTreeToggle<CR>
" Override warning. Overrides a native feature.
nnoremap <C-f> :NERDTreeFind<CR>

