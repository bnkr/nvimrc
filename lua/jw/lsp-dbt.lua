-- Configure lsp for dbt development.
--
-- https://github.com/fivetran/dbt-language-server
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
local util = require 'lspconfig.util'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'

-- This follows the docs here but does not work at all.
--
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/lspconfig.txt 
--
-- See *lspconfig-new*.
if not configs.dbt then
  local root_files = {
    'dbt_project.yml',
  }

  configs.dbt = {
    default_config = {
      cmd = {'dbt', 'lsp'},
      filetypes = {'sql'},
      root_dir = util.root_pattern(unpack(root_files)),
      settings = {},
    },
  }
end

-- Part of the recommended configuration.  I have no idea what this does.
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- "Errror" referencing nil value.
-- lspconfig.dbt.setup {
-- }

-- Maybe we're better off with this?
-- lsp.sqls.setup {
-- }
