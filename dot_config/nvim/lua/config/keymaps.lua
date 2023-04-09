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
map("n", "<C-W>x", "<C-W>q", { desc = "Close window" })
map("n", '<C-W>"', "<C-W>s", { desc = "Split window below" })
map("n", "<C-W>%", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Force quit!" })
