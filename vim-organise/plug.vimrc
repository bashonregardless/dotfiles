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
  call minpac#add('preservim/nerdtree', {'type': 'start'})
  call minpac#add('tpope/vim-unimpaired', {'type': 'start'})
  call minpac#add('tpope/vim-unimpaired', {'type': 'start'})
  call minpac#add('tpope/vim-repeat', {'type': 'start'})
  "[Refer: http://vimcasts.org/blog/2013/02/habit-breaking-habit-making/]
  call minpac#add('wikitopian/hardmode', {'type': 'start'})
  call minpac#add('Yggdroot/indentLine', {'type': 'start'})
  call minpac#add('tpope/vim-commentary', {'type': 'start'})
  call minpac#add('RRethy/vim-illuminate', {'type': 'start'})
  "call minpac#add('Pocco81/auto-save.nvim', {'type': 'start'})

  "call minpac#add('ryanoasis/vim-devicons', {'type': 'start'})

  " Autocomplete Plugins ---------------------- {{{
  " Plugins are for lsp completion/autocompletion
  call minpac#add('hrsh7th/cmp-nvim-lsp', {'type': 'start'})
  call minpac#add('hrsh7th/cmp-buffer', {'type': 'start'})
  call minpac#add('hrsh7th/cmp-path', {'type': 'start'})
  call minpac#add('hrsh7th/cmp-cmdline', {'type': 'start'})
  call minpac#add('hrsh7th/nvim-cmp', {'type': 'start'})
  call minpac#add('hrsh7th/cmp-vsnip', {'type': 'start'})
  call minpac#add('hrsh7th/vim-vsnip', {'type': 'start'})
  " }}}


  " In ex-mode call 
  "+ PluginUpdate	- to update plugin usgin minpac
  "+ PluginClean		- to clean plugin usgin minpac
  command! PackUpdate call minpac#update()
  command! PackClean call minpac#clean()
endif
" }}}

