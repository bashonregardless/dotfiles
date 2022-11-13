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
