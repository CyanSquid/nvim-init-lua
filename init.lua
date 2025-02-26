vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    { 
        'folke/tokyonight.nvim',
        priority = 1000,
        config = function()
            require('tokyonight').setup {
                styles = {
                    comments = { italic = false },
                },
            }
        vim.cmd.colorscheme 'tokyonight-night'
        end,
    },

    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs', 
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
    },

    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("harpoon"):setup()
        end,
        keys = {
            { "<leader>a", function() require("harpoon"):list():append() end, desc = "harpoon file", },
            { "<leader>l", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
            { "<leader>n", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
            { "<leader>e", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
            { "<leader>i", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
            { "<leader>o", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
        },
    },
})

