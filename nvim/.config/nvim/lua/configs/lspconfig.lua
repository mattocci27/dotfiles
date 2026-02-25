-- -- Load NvChad defaults (like lua_ls)
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- List your servers here
local servers = { "html", "cssls" }

-- Loop through and initialize servers using the new 0.11+ syntax
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
  
  -- This tells Neovim to actually start the server for its filetypes
  vim.lsp.enable(lsp)
end

-- Example: Configuring a single server with specific settings (like ts_ls)
-- vim.lsp.config("ts_ls", {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   -- settings = { ... } -- custom settings go here
-- })
-- vim.lsp.enable("ts_ls")
