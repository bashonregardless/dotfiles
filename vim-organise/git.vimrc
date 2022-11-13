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
