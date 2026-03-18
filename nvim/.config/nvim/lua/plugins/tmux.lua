return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "← tmux/nvim" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "↓ tmux/nvim" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "↑ tmux/nvim" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "→ tmux/nvim" },
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", desc = "Navigate to previous (Tmux)" },
    },
  },
}
