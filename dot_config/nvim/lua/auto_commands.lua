--[[ auto_commands.lua ]]
-- Clear the group before adding new commands (for reloading config)
local group = vim.api.nvim_create_augroup('RobsCustomGroup', { clear = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = group,
  pattern = '*',
})

-- [[ Set filetype for .html.erb files ]]
-- See `:help ft-eruby.html`
vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
  callback = function()
    vim.bo.filetype = 'eruby.html'
  end,
  group = group,
  pattern = '*.html.erb',
})

vim.notify('Config reloaded', vim.log.levels.INFO, { title = 'Neovim' })

vim.cmd([[
  augroup ReloadConfig
    autocmd!
    autocmd BufWritePost ~/.config/nvim/* luafile ~/.config/nvim/init.lua
  augroup END
]])
