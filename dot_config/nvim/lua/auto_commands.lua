--[[ auto_commands.lua ]]

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Apply dotfiles when they are written
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "~/.local/share/chezmoi/*",
  command = "! chezmoi apply --source-path \"%\"",
})

-- Reload vim config when updated
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "~/.config/nvim/*", "~/.local/share/chezmoi/dot_config/nvim",
  command = "source $MYVIMRC | Lazy sync",
})
