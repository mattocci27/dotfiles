local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", ':call VSCodeNotify("workbench.action.navigateLeft")<CR>', opts)
keymap("n", "<C-j>", ':call VSCodeNotify("workbench.action.navigateDwon")<CR>', opts)
keymap("n", "<C-k>", ':call VSCodeNotify("workbench.action.navigateUp")<CR>', opts)
keymap("n", "<C-l>", ':call VSCodeNotify("workbench.action.navigateRight")<CR>', opts)

-- Buffers
keymap("n", "<S-l>", ':call VSCodeNotify("workbench.action.nextEditor")<CR>', opts)
keymap("n", "<S-h>", ':call VSCodeNotify("workbench.action.previousEditor")<CR>', opts)
-- keymap("n", "<tab>", ':call VSCodeNotify("workbench.action.nextEditor")<CR>', opts)
-- keymap("n", "<S-tab>", ':call VSCodeNotify("workbench.action.previousEditor")<CR>', opts)
-- keymap("n", "gt", ':call VSCodeNotify("workbench.action.nextEditor")<CR>', opts)
-- keymap("n", "gT", 'call VSCodeNotify("workbench.action.previousEditor")<CR>', opts)


-- fomat
keymap("n", "==", '<Cmd>call VSCodeNotify("editor.action.formatDocument")<CR>', opts)
-- vim.cmd([[
-- nnoremap == <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
-- ]])

-- Commentary <C-/>?
keymap("x", "gc", "<Plug>VSCodeCommentary", {noremap = false})
keymap("n", "gc", "<Plug>VSCodeCommentary", {noremap = false})
keymap("o", "gc", "<Plug>VSCodeCommentary", {noremap = false})
keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", {noremap = false})

--  fzf
keymap("n", "<C-g>", ':call VSCodeNotify("fzf-quick-open.runFzfSearch")<CR>', opts)

-- Which-Key
keymap("n", "<Space>", ':call VSCodeNotify("whichkey.show")<CR>', opts)
