--[[ keymaps.lua ]]

-- See `:help vim.keymap.set()`

vim.keymap.set({ 'n', 'v' }, '<leader>', '<Nop>', { silent = true })

-- j/k will move virtual lines (lines that wrap)
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Tab mappings.
vim.keymap.set({ 'n', 'v' }, '<leader>tt', ':tabnew<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>tn', ':tabnext<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>tp', ':tabprevious<CR>', { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- No arrow keys
vim.keymap.set({ 'n', 'v' }, '<Up>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Down>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Left>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Right>', '<Nop>', { silent = true })

-- Fix common typos
vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev W1 w!
    cnoreabbrev w1 w!
    cnoreabbrev Q! q!
    cnoreabbrev Q1 q!
    cnoreabbrev q1 q!
    cnoreabbrev Qa! qa!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wa wa
    cnoreabbrev Wq wq
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev wq1 wq!
    cnoreabbrev Wq1 wq!
    cnoreabbrev wQ1 wq!
    cnoreabbrev WQ1 wq!
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qa qa
    cnoreabbrev Qall qall
]])
