" source /usr/share/vim/vimrc

" Load file specific plugins.  Note that modes usually will partly work
" without this.
filetype plugin indent on

" Vim-plug stuff (if we use that).  Remember to call PlugInstall after messing
" with this.
call plug#begin(stdpath('data') . '/plugged')

" Connection to language servers.  Requires install of, e.g.
"
"   npm i -g pyright # for python
Plug 'neovim/nvim-lspconfig'
" Allows completion to work (in combination with the lsp server)
Plug 'nvim-lua/completion-nvim'
" :Commentary function.  Comments and uncomments code.
Plug 'tpope/vim-commentary'
" Provides a better python indent by default.
Plug 'Vimjas/vim-python-pep8-indent'
" Terraform indent.
Plug 'hashivim/vim-terraform'

" Snippets to insert some pre-cooked code.  You need at least some of this
" with LSP.
"
" These do not work properly.  They cannot find the python provider and
" constantly spam errors, breaking the completion entirely if they are
" installed.
" Plug 'SirVer/ultisnips'
" Some pre-built snippets.
" Plug 'honza/vim-snippets'

" Snipets that don't python3 system dependencies.  At time of writing I only
" need this for making lsp snippets not crash the completion engine so I'm not
" fussed with anything else.
Plug 'L3MON4D3/LuaSnip'

" Better than the built-in completion generally.  This is the 'recommended'
" configuration from the completion docs.
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Gives pictograms in the completion menu that say where things are coming
" from.  This ties in with vim-cmp.
Plug 'onsails/lspkind-nvim'

" Rust lsp tools.
Plug 'simrat39/rust-tools.nvim'

call plug#end()

" Don't care about legacy vim.
set nocompatible
" Do shell-like completion (ie, pop up a list instead of iterating all the
" matches with tab.
set wildmode=longest,list
" For auto-complete, show a menu (even for one match), and preview the change.
set completeopt=menuone,preview
" Enable indenting.
set autoindent
" C commenting:
"
" :0 = indent a case label zero characters (i.e keep it indented to the position
"      of the switch token)
" (s = use shiftwidth to indent after an unclosed parenthesis
" U1 = do (s even if the open bracket is the first char on the line
" Ws = use shitwidth when indenting a line after unclosed paren if the line is
"      long
" m1 = de-indent a closing parenthesis on an empty line
" h0 = don't indent after an access modifier (public/private etc)
set cinoptions=:0,(s,U1,Ws,m1,h0

" Default format options:
"
" c = auto-wrap comments using textwidth.
" r = auto-insert the comment char(s) when you press enter after a comment.
" o (missing) = don't insert a comment with the insert line o or O.
" q = 'Allow formatting of comments with the "gq" command'
" n = recognise numbered lists and wrap.
" l = don't break lines which are already too long.
set formatoptions=crqnl

" Set various indenting things.
set smarttab
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal tabstop=4

" Show tabs as >>, because otherwise I mess up people's indenting.  Listchars
" is specified because otherwise it shows eol as well.  Trail is for trailing
" spaces.
set list
set listchars=tab:»·,trail:·

" Enable coloruing and set a decent scheme.
syntax enable
colorscheme pablo

" I typo a lot.
map :W :w
map :E :e
" Python mode needs some help locating python.  We don't really use python
" mode any more as the lsp does the same job.
let g:pymode_python = 'python3'

setlocal ruler
setlocal hlsearch
set number

" Prettier colour for line numbers.
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
highlight LineNr gui=NONE guifg=DarkGrey guibg=NONE

" Make cursor more visible (not working)
highlight Cursor term=bold ctermfg=White ctermbg=Red
highlight iCursor term=bold ctermfg=White cterm=bold ctermbg=Red

" Completion popup is a bit obnoxious as pink.
hi Pmenu guifg=fg guibg=#303030 gui=NONE cterm=NONE ctermbg=DarkGrey
hi PmenuSbar guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuSel guifg=#000000 guibg=#e5e5e5 gui=NONE cterm=NONE
hi PmenuThumb guifg=NONE guibg=#ffffff gui=NONE cterm=NONE

 " Sort of works to make the cursor more visible.  Not perfect.
set guicursor=

" Vim started to refuse to close the file listing buffer unless you deleted
" the buffer by number.  This solution seems to avoid this.
"
" See https://vi.stackexchange.com/questions/14622/how-can-i-close-the-netrw-buffer.
set nohidden
augroup netrw_buf_hidden_fix
  autocmd!

  " Set all non-netrw buffers to bufhidden=hide
  autocmd BufWinEnter *
        \  if &ft != 'netrw'
        \|     set bufhidden=hide
        \| endif
augroup end


" Remove trailing whitespace from files that shouldn't have them
" Complicated formulation to avoid writing over the substitution
" history (which kind of works).
autocmd FileType docbk,xxs,c,cpp,java,php,ruby,cmake,latex,lemon,tex,asciidoc,sh,vim,haskell,python,cucumber,terraform,rust
      \ autocmd BufWritePre <buffer>
      \ :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Let me indent with tab.
map <Tab> >0
map <S-Tab> <0

" Quicker way to comment one line vs. 'gc<right>'.
map <S-CR> :Commentary<CR>

" This applies to lsp completion also.
set completeopt+=menuone,noinsert,noselect
" Completion matching.  This is specific to the built-in completion but does't
" do any harm to be set for everything./
let g:completion_metching_strategy_list = ['exact', 'substring', 'fuzzy']

lua require('jw/cmp')
lua require('jw/lsp-python')
lua require('jw/lsp-rust')
lua require('jw/lsp-terraform')
