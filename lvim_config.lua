-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab
vim.opt.relativenumber = true -- relative line numbers
vim.opt.wrap = true -- wrap lines

-- use treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

lvim.plugins = {
    {
        "tpope/vim-fugitive",
        cmd = {
            "G",
            "Git",
            "Gdiffsplit",
            "Gread",
            "Gwrite",
            "Ggrep",
            "GMove",
            "GDelete",
            "GBrowse",
            "GRemove",
            "GRename",
            "Glgrep",
            "Gedit"
        },
        ft = {"fugitive"}
    },
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup()
        end,
    },
    {
        "kevinhwang91/nvim-bqf",
        ft="qf"
    },
    { "ellisonleao/gruvbox.nvim" },
    { "tpope/vim-repeat" },
    { "ggandor/leap.nvim",
        config = function()
            require('leap').add_default_mappings(true)
        end,
    },
    { "github/copilot.vim" },
    {
        "prettier/vim-prettier",
        run = "yarn install",
        ft = { "javascript", "typescript", "css", "less", "scss", "json", "graphql", "markdown" }
    }
}

--- [Refer: https://github.com/LunarVim/LunarVim/issues/1856#issuecomment-954224770]
--- Use <C-e> to dismiss the cmp completion menu and then use <Tab> to accept the copilot suggestions
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
local cmp = require "cmp"

lvim.builtin.cmp.mapping["<Tab>"] = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        local copilot_keys = vim.fn["copilot#Accept"]()
        if copilot_keys ~= "" then
            vim.api.nvim_feedkeys(copilot_keys, "i", true)
        else
            fallback()
        end
    end
end
---
