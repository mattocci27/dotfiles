return {
  {
    "stevearc/conform.nvim",
    -- Uncomment to enable format on save
    -- event = 'BufWritePre',
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc", "html", "css",
      },
    },
  },
  {
    "ojroques/nvim-osc52",
    keys = {
      {
        "<leader>y",
        function() require("osc52").copy_operator() end,
        desc = "Copy selection to system clipboard (normal mode)",
        expr = true,
      },
      {
        "<leader>Y",
        "<leader>y_",
        remap = true,
        desc = "Copy current line into system clipboard (normal mode)",
      },
      {
        mode = "v",
        "<leader>y",
        function() require("osc52").copy_visual() end,
        desc = "Copy selection to system clipboard (visual mode)",
      },
    },
  },
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
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "Navigate left (Tmux)" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "Navigate down (Tmux)" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "Navigate up (Tmux)" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right (Tmux)" },
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", desc = "Navigate to previous (Tmux)" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain",
    keys = { { "<leader>nn", "<cmd>NoNeckPain<CR>", desc = "No Neck Pain Mode" } },
    opts = {},
  },
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    opts = {
      lspFeatures = {
        languages = { "r", "python", "julia", "bash", "lua", "html", "dot", "javascript", "typescript", "ojs" },
      },
      codeRunner = {
        enabled = true,
        default_method = "slime",
      },
    },
    dependencies = {
      {
        "jmbuhr/otter.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        opts = {
          lsp = {
            hover = { border = "rounded" }, -- Define `border_style` if needed
          },
          buffers = { set_filetype = true },
          handle_leading_whitespace = true,
        },
      },
    },
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },
  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "nvchad/volt",
    lazy = true,
  },
  {
    "williamboman/mason.nvim",
  },
}
