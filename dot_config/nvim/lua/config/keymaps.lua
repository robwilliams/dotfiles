-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- windows (match tmux keybindings)
map("n", "<C-W>x", "<C-W>q", { desc = "Quit window (RW)" })
map("n", '<C-W>"', "<C-W>s", { desc = "Split window below (RW)" })
map("n", "<C-W>%", "<C-W>v", { desc = "Split window right (RW)" })

-- tabs
map("n", "<leader>tt", "<cmd>tabnew<cr>", { desc = "New Tab (RW)" })
map("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "Next Tab (RW)" })
map("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "Previous Tab (RW)" })
