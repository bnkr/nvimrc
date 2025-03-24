-- Configures the the cmp plugin the way I like it.  Requires various plugins
-- and assumes that the lsp is going to get configured as well.
--
-- Reference:
--
--   https://github.com/neovim/nvim-lspconfig -- basic setup
--   https://github.com/jim-at-jibba/my-dots/blob/master/nvim/lua/my_lspconfig.lua -- james best's config.
--   https://pastebin.com/XcJShCSb -- various handy configs
local cmp = require('cmp')
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
-- Press K to show documentation for the thing under cursor.
vim.api.nvim_command('nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>')
-- Overrule default ctags style jump to definition and use lsp for it.
vim.api.nvim_command('noremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>')


-- TODO:
--   here's some other good shortcuts that might be handy:
--
--   https://www.integralist.co.uk/posts/neovim/

-- Tell vim how to access the code completion menu.
vim.cmd("setlocal omnifunc=v:lua.vim.lsp.omnifunc")

-- Easier way to get to the code completion menu.  Doesn't really work the way
-- I want because it wil only complete the portion of the word before the
-- cursor.  This might potentially be triggering a different autocomplete
-- behaviour which is why it's not working as expected.
vim.cmd('inoremap <c-n> <c-x><c-o>')

-- Ripped off from james best.
cmp.setup({

  confirmation = { default_behavior = cmp.ConfirmBehavior.Replace },

  -- Keymaps copied from the default.  With some of these wrong it doesn't work
  -- at all.
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),

  -- See https://github.com/neovim/nvim-lspconfig/wiki/Snippets for ideas an
  -- examples.  This must be set proprerly of snippets (even from the LSP) will
  -- crash completion.
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  sources = {
    { name = "buffer" },
    { name = 'luasnip' },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "spell" },

    -- Some AI bot I don't need.
    -- { name = "cmp_tabnine" },
  },
})
