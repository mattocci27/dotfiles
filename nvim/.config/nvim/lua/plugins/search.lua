return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        ignored = true,
        sources = {
          files = {
            hidden = true,
            ignored = true,
          },
        },
      },
      explorer = {
        hidden = true,
        ignored = true,
      },
      terminal = {
        win = {
          style = "float",
          border = "rounded",
        },
      },
    },
  },

  -- 🔎 Telescope (検索)
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = { hidden = true }, -- .dotfiles 見える
      },
    },
  },
}
