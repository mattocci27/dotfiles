-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local groups = {
      "Normal",
      "NormalNC",
      "NormalFloat",
      "FloatBorder",
      "SignColumn",
      "EndOfBuffer",
      "StatusLine",
      "StatusLineNC",
      "TabLineFill",
      "WinSeparator",
    }
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
    end
  end,
})

-- apply immediately for the current colorscheme too
local groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "FloatBorder",
  "SignColumn",
  "EndOfBuffer",
  "StatusLine",
  "StatusLineNC",
  "TabLineFill",
  "WinSeparator",
}
for _, group in ipairs(groups) do
  vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
end
