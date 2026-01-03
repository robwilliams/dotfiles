-- Minimal nvim config

vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.wrap = true
vim.o.clipboard = ""
vim.opt.iskeyword:append("-")

vim.keymap.set("n", "Q", "<nop>")

vim.cmd([[
  cnoreabbrev W! w!
  cnoreabbrev W1 w!
  cnoreabbrev w1 w!
  cnoreabbrev Q! q!
  cnoreabbrev Q1 q!
  cnoreabbrev q1 q!
  cnoreabbrev Wq wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
]])
