return {
  {
    "vim-test/vim-test",
    lazy = true,
    keys = {
      { "<leader>t", "<cmd>TestNearest<cr>", desc = "Test Nearest (RW)" },
      { "<leader>f", "<cmd>TestFile<cr>", desc = "Test File (RW)" },
      { "<leader>l", "<cmd>TestLast<cr>", desc = "Test Last (RW)" },
    },
    config = function()
      vim.g["test#strategy"] = "vtr"
    end,
    dependencies = {
      "christoomey/vim-tmux-runner",
    },
  },
}
