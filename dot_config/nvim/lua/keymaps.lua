--[[ keymaps.lua ]]
-- See `:help vim.keymap.set()sdasddsfdf

vim.keymap.set({ 'n', 'v' }, '<leader>', '<Nop>', { silent = true })

-- j/k will move virtual lines (lines that wrap)
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- No arrow keys
vim.keymap.set({ 'n', 'v' }, '<Up>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Down>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Left>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Right>', '<Nop>', { silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selected line(s) down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selected line(s) up

vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in the middle
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Down" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]]) -- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- delete but place into black hole register

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>w", "<cmd>:w<CR>")

vim.keymap.set("n", "<leader>tt", "<cmd>:tabnew<CR>")
vim.keymap.set("n", "<leader>tn", "<cmd>:tabnext<CR>")
vim.keymap.set("n", "<leader>tp", "<cmd>:tabprevious<CR>")
vim.keymap.set("n", "<leader>tq", "<cmd>:tabclose<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>:bdelete<CR>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "[S]wap word under cursor" })

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
