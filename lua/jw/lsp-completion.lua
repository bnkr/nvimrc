-- Alternative lsp configuration using the built-in completion system.  This
-- uses a scratch buffer which gets really annoying because when you delete a
-- normal buffer the scratch buffer becomes somehow unassociated to the
-- completion and won't re-open.
local lsp = require('lsp')

-- TODO:
--   can we make it so that lsp can be initialised in a different palce?  The
--   only thing is this on attach function.
lsp.pyright.setup { on_attach = require'completion'.on_attach }

-- Use tab to advance completion options and insert the auto-import as you go
-- rather than scrolling and pressing enter.
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

-- ctrl+p triggers the completion memu in insert mode.  This probably relies on
-- us usign the built-in completion.
--
-- TODO:
--   This does not work to trigger auto-imports for already completed words
--   because the auto-import doesn't do anything when there's something else on
--   the line.
imap <silent> <c-p> <Plug>(completion_trigger)
