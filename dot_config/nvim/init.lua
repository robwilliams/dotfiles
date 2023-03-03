--[[ init.lua ]]
-- Goodbye, netrw! My old friend.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- These need to be defined before the first <Leader>
-- is called; otherwise, it will default to "\".
vim.g.mapleader = " "
vim.g.localleader = " "

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('options')
require('keymaps')
require('auto_commands')
require('plugins')
