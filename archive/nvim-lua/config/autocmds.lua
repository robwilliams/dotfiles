-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("rw_" .. name, { clear = true })
end

-- Set the dispatch command to chezmoi apply for chezmoi files.
vim.api.nvim_create_autocmd("BufRead", {
  group = augroup("chezmoi"),
  pattern = "*/chezmoi/*",
  callback = function()
    vim.b.dispatch = "chezmoi apply -v"
  end,
})
