-- Leader must be set before mappings/plugins
vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

-- Timing
vim.opt.timeoutlen = 300

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 2
vim.opt.foldcolumn = "3"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Open Neovim config quickly
vim.keymap.set("n", "<leader>c", function()
	vim.cmd("edit " .. vim.fn.expand("~/dotfiles/nvim/.config/nvim/init.lua"))
end, opts)

-- Clear search highlighting
vim.keymap.set("n", "<leader>n", "<cmd>nohlsearch<CR>", opts)

-- VSCode editor navigation
vim.keymap.set("n", "<S-l>", function()
	vim.fn.VSCodeNotify("workbench.action.nextEditor")
end, opts)

vim.keymap.set("n", "<S-h>", function()
	vim.fn.VSCodeNotify("workbench.action.previousEditor")
end, opts)

-- Optional: show which-key in VSCode
vim.keymap.set("n", "<Space>", function()
	vim.fn.VSCodeNotify("whichkey.show")
end, opts)

-- lazy.nvim bootstrap for VSCode-only plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
})
