---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

M.vimTmuxNavigator = {
  plugin = true,
  n = {
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>", "Navigate Tmux" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>", "Navigate Tmux" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>", "Navigate Tmux" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>", "Navigate Tmux" },
  }
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<leader>i"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<leader>i"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },
  },
}
-- more keybinds!

return M
