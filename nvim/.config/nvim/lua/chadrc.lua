-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "gruvbox",
  theme_toggle = { "gruvbox", "one_light" },
  -- hl_override = highlights.override,
  -- hl_add = highlights.add,
  transparency = true,
  nvdash = {
    load_on_startup = true,
  },
}

return M
