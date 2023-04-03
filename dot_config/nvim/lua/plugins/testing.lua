return {
  {
    "vim-test/vim-test",
    lazy = true,
    keys = {
      { "<C-d>t", "<cmd>TestNearest<cr>", desc = "Test Nearest (RW)" },
      { "<C-d>f", "<cmd>TestFile<cr>", desc = "Test File (RW)" },
      { "<C-d>l", "<cmd>TestLast<cr>", desc = "Test Last (RW)" },
    },
    config = function()
      vim.g["test#strategy"] = "vtr"
    end,
    dependencies = {
      "christoomey/vim-tmux-runner",
    },
  },
}
