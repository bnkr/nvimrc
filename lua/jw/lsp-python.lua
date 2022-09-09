-- Configures python lsp.
--
-- Requirements:
--
--   npm i -g pyright # for python
local lsp = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Part of the recommended configuration.  I have no idea what this does.
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

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
