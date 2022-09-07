-- Rust lsp activation.  I guess the actual lsp config is burried in rust-tools
-- rather than using vim's very own lspconfig,
--
-- This will require on the system:
--
--    brew install rust-analyzer
--
-- Not to mention nvim >= 0.7.
--
-- See:
--
-- * https://vimawesome.com/plugin/rust-tools-nvim
local rust = require('rust-tools')

local opts = {
  -- rust-tools options
  tools = {
    autoSetHints = true,

    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
  -- https://rust-analyzer.github.io/manual.html#features
  server = {
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importEnforceGranularity = true,
          importPrefix = "crate"
          },
        cargo = {
          allFeatures = true
          },
        checkOnSave = {
          -- default: `cargo check`
          command = "clippy"
          },
        },
        inlayHints = {
          lifetimeElisionHints = {
            enable = true,
            useParameterNames = true
          },
        },
      }
    },
}

rust.setup(opts)
