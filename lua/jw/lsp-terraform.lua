-- Hashicorp's terraform LSP.  This is the "safe" one with not too many features.
--
-- Requires:
--
-- * brew install terraform-ls
--
-- https://github.com/hashicorp/terraform-ls/blob/main/docs/USAGE.md#neovim-v050
local lspconfig = require('lspconfig')

lspconfig.terraformls.setup {}
