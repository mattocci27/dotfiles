return {
  {
    "riodelphino/macime.nvim",
    enabled = vim.fn.has("mac") == 1,
    event = "VimEnter",
    opts = {
      vim = {
        ttimeoutlen = 0,
      },
      ime = {
        default = "com.apple.keylayout.ABC",
      },
      save = {
        enabled = true,
        scope = "session",
      },
      socket = {
        enabled = true,
      },
      exclude = {
        filetype = {
          "TelescopePrompt",
          "snacks_picker_input",
          "neo-tree-popup",
          "neo-tree-filter",
        },
      },
    },
  },
}
