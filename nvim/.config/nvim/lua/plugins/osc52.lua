return {
  {
    "ojroques/nvim-osc52",
    keys = {
      {
        "<leader>y",
        function()
          return require("osc52").copy_operator()
        end,
        expr = true,
        desc = "Copy to system clipboard",
      },
      {
        "<leader>Y",
        "<leader>y_",
        remap = true,
        desc = "Copy line to system clipboard",
      },
      {
        "<leader>y",
        function()
          require("osc52").copy_visual()
        end,
        mode = "v",
        desc = "Copy selection to system clipboard",
      },
    },
    init = function()
      require("osc52").setup({})
    end,
  },
}
