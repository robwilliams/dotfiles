-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- Don't make a backup before overwriting a file.
vim.o.nobackup = true
vim.o.nowritebackup = true

-- Disable swap files.
vim.o.swapfile = false

-- Wrap lines.
vim.o.wrap = true

-- Do not use the system clipboard.
vim.o.clipboard = ""
