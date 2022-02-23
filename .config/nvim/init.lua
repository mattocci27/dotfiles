if vim.fn.exists("g:vscode") == 1 then
  require "user.options"
  require "vscode.settings"

  local opts = { noremap = true, silent = true }

  local term_opts = { silent = true }

  -- Shorten function name
  local keymap = vim.api.nvim_set_keymap

  --Remap space as leader key
  keymap("", "<Space>", "<Nop>", opts)
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Modes
  --   normal_mode = "n",
  --   insert_mode = "i",
  --   visual_mode = "v",
  --   visual_block_mode = "x",
  --   term_mode = "t",
  --   command_mode = "c",

  -- Normal --
  -- Better window navigation
  keymap("n", "<C-h>", ':call VSCodeNotify("workbench.action.navigateLeft")<CR>', opts)
  keymap("n", "<C-j>", ':call VSCodeNotify("workbench.action.navigateDwon")<CR>', opts)
  keymap("n", "<C-k>", ':call VSCodeNotify("workbench.action.navigateUp")<CR>', opts)
  keymap("n", "<C-l>", ':call VSCodeNotify("workbench.action.navigateRight")<CR>', opts)

  -- Buffer>s
  keymap("n", "<S-l>", ':call VSCodeNotify("workbench.action.nextEditor")<CR>', opts)
  keymap("n", "<S-h>", ':call VSCodeNotify("workbench.action.previousEditor")<CR>', opts)

  -- Commentary <C-/>?
  keymap("x", "gc", "<Plug>VSCodeCommentary", {noremap = false})
  keymap("n", "gc", "<Plug>VSCodeCommentary", {noremap = false})
  keymap("o", "gc", "<Plug>VSCodeCommentary", {noremap = false})
  keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", {noremap = false})

  --  fzf
  keymap("n", "<C-g>", ':call VSCodeNotify("fzf-quick-open.runFzfSearch")<CR>', opts)

  -- r pipe
  -- keymap("i", "<C-p>", '\|>', opt)

  -- Which-Key
  keymap("n", "<Space>", ':call VSCodeNotify("whichkey.show")<CR>', opts)

else
  --require "user.optionｊ"
  --require "user.keymaps"
  --require "user.plugins"
  --require "user.colorscheme"
  --require "user.cmp"
  --require "user.lsp"
  --require "user.telescope"
  --require "user.treesitter"
  --require "user.autopairs"
  --require "user.comment"
  --require "user.gitsigns"
  --require "user.nvim-tree"
  --require "user.bufferline"
  --require "user.lualine"
  --require "user.toggleterm"
  --require "user.project"
  --require "user.impatient"
  --require "user.indentline"
  --require "user.alpha"
  --require "user.whichkey"
  --require "user.autocommands"

-- Neovim
  vim.cmd([[
    exe 'source $HOME/dotfiles/nvim_config/10_settings.vim'
    exe 'source $HOME/dotfiles/nvim_config/20_keybindings.vim'
    exe 'source $HOME/dotfiles/nvim_config/30_plugins.vim'
    exe 'source $HOME/dotfiles/nvim_config/40_color.vim'
  ]])
end
