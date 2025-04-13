-- Options table for key mappings
local opts = { noremap = true, silent = true }

      
-- Set timeout length to 500ms for leader key sequences
vim.opt.timeoutlen = 300

-- Set the leader key to space for easier access to leader mappings
vim.g.mapleader = ' '

--- Folding
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 2
vim.opt.foldcolumn = '3'


-- Key mapping to open the Neovim configuration file quickly from normal mode
vim.cmd('nmap <leader>c :e ~/dotfiles/nvim/.config/nvim/init.lua<cr>')

-- Clipboard settings to allow Neovim to use the system clipboard
vim.opt.clipboard = 'unnamedplus'
-- Search settings to make searches case-insensitive unless they contain uppercase letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Key mapping to clear search highljghting using the leader key followed by 'n'
vim.keymap.set('n', '<leader>n', ':nohlsearch<CR>', opts)

-- Key mapping for triggering the fzf quick-open search with the leader key followed by 'g'
-- This utilizes the VSCodeNotify function to interact with VSCode's command palette
-- I do this on keybindings.json
-- vim.keymap.set("n", "<leader>g", ':call VSCodeNotify("fzf-quick-open.runFzfSearch")<CR>', opts)

-- Key mapping to show the "whichkey" display using the Space key in normal mode
vim.keymap.set("n", "<Space>", ':call VSCodeNotify("whichkey.show")<CR>', opts)

-- Key mappings to navigate between open editors (tabs) in VSCode using Shift+L and Shift+H
vim.keymap.set("n", "<S-l>", ':call VSCodeNotify("workbench.action.nextEditor")<CR>', opts)
vim.keymap.set("n", "<S-h>", ':call VSCodeNotify("workbench.action.previousEditor")<CR>', opts)

-- LazyVim Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {"xiyaowong/fast-cursor-move.nvim"}, -- Corrected syntax
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },
})

