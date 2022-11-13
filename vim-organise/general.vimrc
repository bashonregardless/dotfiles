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

