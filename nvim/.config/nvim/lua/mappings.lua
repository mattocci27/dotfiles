require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")


-- Vim Tmux Navigator mappings
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate Tmux left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate Tmux down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate Tmux up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate Tmux right" })

-- -- Nvterm mappings
map("t", "<leader>i", function()
  require("nvchad.term").toggle({pos = "float"}) 
end, { desc = "Toggle floating terminal in terminal mode" })

map("n", "<leader>i", function()
  require("nvchad.term").toggle({pos = "float"}) 
end, { desc = "Toggle floating terminal in normal mode" })
