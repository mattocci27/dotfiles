local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--
-- Disable swap file creation
vim.opt.swapfile = false

-- Set indentation options
vim.opt.shiftwidth = 1
vim.opt.tabstop = 2
vim.opt.expandtab = true
-- vim.opt.clipboard = ""
