-- Configures python lsp.

local lsp = require('lspconfig')

-- Part of the recommended configuration.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Python language server.  It's merely OK.  Needs a lot of stubs.
lsp.pyright.setup { 
  on_attach = on_attach,
  capabilities = capabilities
}

-- A more featureful but less fast language server.  Idea is to load this in a
-- docker container but this only work when the service is over tcp or so...
-- lsp.pylsp.setup {
--   on_attach = on_attach,
--   filetypes = {"python"},
--   capabilities = capabilities
-- }
--
