require'lspconfig'.vimls.setup{}

-- Copied from github repo nvim-lspconfig by mjlbach
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
-- [Refer: vim-docs file point 7]
vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
-- [Refer: vim-docs file point 7]
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
  })

local function buf_set_keymap(...) 
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ...) 
end

local function buf_set_option(...) 
  vim.api.nvim_buf_set_option(bufnr, 'n', ...) 
end

-- Enable completion triggered by <c-x><c-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('<space>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('<space>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('<space>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('<space>h', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
buf_set_keymap('<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
buf_set_keymap('<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
buf_set_keymap('<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('<space>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver', 'vimls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

-- local function set_keymap(...)
--   vim.api.nvim_set_keymap('n', ...)
-- end

-- -- Jump Mappings
-- set_keymap('gd', '', { callback = vim.lsp.buf.definition, desc = 'Jump to definition' })

-- set_keymap('gy', '', { callback = vim.lsp.buf.declaration, desc = 'Jump to declaration' })

-- set_keymap('gr', '', { callback = vim.lsp.buf.references, desc = 'Jump to references' })

-- set_keymap('gi', '', { callback = vim.lsp.buf.implementation, desc = 'Jump to implementation' })

-- -- Information
-- set_keymap('K', '', { callback = vim.lsp.buf.hover, desc = 'Show hover information - Docs' })
-- set_keymap('<C-k>', '', { callback = vim.lsp.buf.hover, desc = 'Show hover information - Docs' })
-- -- Code Actions
-- -- Rename
-- set_keymap('<leader>rn', '', { callback = vim.lsp.buf.rename, desc = 'Rename symbol' })

