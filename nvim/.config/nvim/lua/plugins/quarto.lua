return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lspFeatures = {
        enabled = true,
        languages = {
          "r",
          "python",
          "julia",
          "bash",
          "lua",
          "html",
          "dot",
          "javascript",
          "typescript",
          "ojs",
        },
      },
      codeRunner = {
        enabled = false,
      },
    },
  },
  {
    "jmbuhr/otter.nvim",
    opts = {
      lsp = {
        hover = {
          border = "rounded",
        },
      },
      buffers = {
        set_filetype = true,
      },
      handle_leading_whitespace = true,
    },
  },
}
