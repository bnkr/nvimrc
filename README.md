Neovim Configuration
====================

Install
-------

Clone into `~/.config/nvim` (by default).

Open nvim and call `:PlugInstall`.

This will work because autoload already contains plug.vim.  You can otherwise
obtain it from https://github.com/junegunn/vim-plug .

Likely nvim itself will not be any good from system packages since it'll be too
old so you'll need a port or download the appimage.  Check the neovim repository
https://github.com/neovim/neovim/blob/master/INSTALL.md .

Last checked the compat on v0.10.4.

LSP Dependencies
----------------

Rust: install rust-analyzer via rustup.

Python: install pyright via npm.  You'll need nvm to get node set up.  Pyenv is
a sensible solution for python itself.
