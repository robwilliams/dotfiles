return {
  {
    "vim-test/vim-test",
    lazy = true,
    keys = {
      -- "<leader>t",
      -- "<leader>f",
      -- "<leader>l",
    },
    config = function()
      vim.g["test#strategy"] = "vtr"
      -- vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
      -- vim.keymap.set("n", "<leader>f", ":TestFile<CR>")
      -- vim.keymap.set("n", "<leader>l", ":TestLast<CR>")
    end,
    dependencies = {
      "christoomey/vim-tmux-runner",
    },
  },
}
