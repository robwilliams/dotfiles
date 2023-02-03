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

-- Apply dotfiles when they are written
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "~/.local/share/chezmoi/*",
  command = "lua os.execute('chezmoi apply --source-path \"%\"') | lua vim.notify('Dotfiles updated')",
  group = group,
})

-- Reload vim config when updated
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "~/.config/nvim/*",
  command = "source $MYVIMRC | Lazy sync | lua vim.notify('Config reloaded')",
  group = group,
})
