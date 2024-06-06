return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
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
  			"lua-language-server", "stylua",
  			"html-lsp", "css-lsp" , "prettier"
  		},
  	},
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css"
  		},
  	},
  },
  {
  "ojroques/nvim-osc52",
  keys = {
    {
      "<leader>y",
      function() return require("osc52").copy_operator() end, -- <-- previously I wasn't using a return statement here
      desc = "copy selection to system clipboard (normal mode)",
      expr = true
    },
    {
      "<leader>Y",
      "<leader>y_",
      remap = true,
      desc = "copy current line into system clipboard (normal mode)"
    },
    {
      mode = "v",
      "<leader>y",
      function() require("osc52").copy_visual() end,
      desc = "copy selection to system clipboard (visual mode)"
    }
   }
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
      { "<C-h>", "<cmd> TmuxNavigateLeft <CR>" },
      { "<C-j>", "<cmd> TmuxNavigateDown <CR>" },
      { "<C-k>", "<cmd> TmuxNavigateUp <CR>" },
      { "<C-l>", "<cmd> TmuxNavigateRight <CR>" },
      { "<C-\\>", "<cmd> TmuxNavigatePrevious <CR>" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
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
    keys = { { "<leader>nn", "<cmd>NoNeckPain<cr>", desc = "[N]o [N]eckpain" } },
    opts = {},
  },
  {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto' },
    dev = false,
    opts = {
      lspFeatures = {
        languages = { 'r', 'python', 'julia', 'bash', 'lua', 'html', 'dot', 'javascript', 'typescript', 'ojs' },
      },
      codeRunner = {
        enabled = true,
        default_method = 'slime',
      },
    },
    dependencies = {
      {
        'jmbuhr/otter.nvim',
        dev = false,
        dependencies = {
          { 'neovim/nvim-lspconfig' },
        },
        opts = {
          lsp = {
            hover = {
              border = border_style,
            },
          },
          buffers = {
            set_filetype = true,
          },
          handle_leading_whitespace = true,
        },
      },
    },
  },
}
