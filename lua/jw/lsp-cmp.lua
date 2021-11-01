-- Configures the nvim lsp integration and completion (using cmp) the way I
-- like it.  Requires various plugins.
--
-- Reference:
--
--   https://github.com/neovim/nvim-lspconfig -- basic setup
--   https://github.com/jim-at-jibba/my-dots/blob/master/nvim/lua/my_lspconfig.lua -- james best's config.
--   https://pastebin.com/XcJShCSb -- various handy configs
local lsp = require('lspconfig')
local cmp = require('cmp')
local lspkind = require("lspkind")
local luasnip = require('luasnip')

-- this might come in handy to avoid us needing to faff about with venv manually.
--vim.g.python_host_prog = "~/.pyenv/versions/neovim2/bin/python"
--vim.g.python3_host_prog = "~/.pyenv/versions/neovim3/bin/python3"

-- Convert things like <tab> to something nvim lua understands.
local function t(c)
  return vim.api.nvim_replace_termcodes(c, true, true, true)
end

-- Press <ca> for code actions.  We must tell vim that certain code actions
-- exist.  Lots of useful code actions do not exist on pyright so yeah.
vim.api.nvim_command('nnoremap <silent> ca <cmd>lua vim.lsp.buf.code_action()<CR>')

-- Tell vim how to access the code completion menu.
vim.cmd("setlocal omnifunc=v:lua.vim.lsp.omnifunc")
-- Easier way to get to the code completion menu.  Doesn't really work the way
-- I want because it wil only complete the portion of the word before the
-- cursor.  Alo this seems to somehow trigger the old method where the scratch
-- buffer shows up rather than doing the standard menu.  Very weird.
vim.cmd('inoremap <c-n> <c-x><c-o>')

-- Ripped off from james best.
cmp.setup({
  confirmation = { default_behavior = cmp.ConfirmBehavior.Replace },
  formatting = {
    format = function(_, item)
      item.kind = lspkind.presets.default[item.kind]
      return item
    end,
  },
  mapping = {
    ["<cr>"] = cmp.mapping.confirm(),
    ["<m-cr>"] = cmp.mapping.confirm({ select = true }),
    -- TODO:
    --   I want this to select the entry but this just exits the menu.
    ["<s-tab>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t("<c-p>"), "n")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<tab>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t("<c-n>"), "n")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  -- See https://github.com/neovim/nvim-lspconfig/wiki/Snippets for ideas an
  -- examples.  This must be set proprerly of snippets (even from the LSP) will
  -- crash completion.
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,

    -- James Best recommends Plugin 'SirVer/ultisnips' which I can't get
    -- working due to some sort of issue with python3 system dependencies
    -- (probably).  luasnips is lua only so less of an issue there.
    -- expand = function(args)
    --   vim.fn['UltiSnips#Anon'](args.body)
    -- end,
  },
  sources = {
    { name = "buffer" },
    -- { name = "ultisnips" },
    { name = 'luasnip' },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "spell" },
    { name = "cmp_tabnine" },
  },
})

lspkind.init({ with_text = false })

-- Part of the recommended configuration.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Python language server.  It's merely OK.  Needs a lot of stubs.
lsp.pyright.setup { 
  on_attach = on_attach,
  capabilities = capabilities
}
