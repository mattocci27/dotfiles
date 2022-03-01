-- vscode
if vim.fn.exists("g:vscode") == 1 then
  require "user.options"
  require "vscode.settings"
-- lunarvim
else
  -- require "user.option"
  -- require "user.keymaps"
  -- require "user.plugins"
  -- require "user.colorscheme"
  -- require "user.cmp"
  -- require "user.lsp"
  -- require "user.telescope"
  -- require "user.treesitter"
  -- require "user.autopairs"
  -- require "user.comment"
  -- require "user.gitsigns"
  -- require "user.nvim-tree"
  -- require "user.bufferline"
  -- require "user.lualine"
  -- require "user.toggleterm"
  -- require "user.project"
  -- require "user.impatient"
  -- require "user.indentline"
  -- require "user.alpha"
  -- require "user.whichkey"
  -- require "user.autocommands"

-- Neovim
  vim.cmd([[
    exe 'source $HOME/dotfiles/nvim_config/10_settings.vim'
    exe 'source $HOME/dotfiles/nvim_config/20_keybindings.vim'
    exe 'source $HOME/dotfiles/nvim_config/30_plugins.vim'
    exe 'source $HOME/dotfiles/nvim_config/40_color.vim'
  ]])
end
