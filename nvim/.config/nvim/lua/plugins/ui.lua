return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.filesystem = opts.filesystem or {}

      opts.filesystem.commands = opts.filesystem.commands or {}
      opts.filesystem.commands.delete_no_confirm = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.fn.delete(path, "rf")
        require("neo-tree.sources.manager").refresh(state.name)
      end

      opts.filesystem.window = opts.filesystem.window or {}
      opts.filesystem.window.mappings = opts.filesystem.window.mappings or {}
      opts.filesystem.window.mappings["d"] = "delete_no_confirm"
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain",
    keys = {
      { "<leader>nn", "<cmd>NoNeckPain<CR>", desc = "No Neck Pain Mode" },
    },
    opts = {},
  },
}
