-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "aquarium",
  -- theme_toggle = { "aquarium", "one_light" },
  -- hl_override = highlights.override,
  -- hl_add = require"hl",
  transparency = true
}

-- UI settings
M.ui = {
  statusline = {
    theme = "default",     -- Statusline theme: default, minimal, etc.
    separator_style = "round", -- Separator style: default, arrow, block, etc.
  },
  tabufline = {
    enabled = true,        -- Enable the tabufline
    lazyload = true,       -- Lazy load when there are multiple buffers
  },
}

M.nvdash = {
  load_on_startup = true,
}


return M
